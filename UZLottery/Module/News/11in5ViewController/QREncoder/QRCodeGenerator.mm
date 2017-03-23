//
// QR Code Generator - generates UIImage from NSString
//
// Copyright (C) 2012 http://moqod.com Andrew Kopanev <andrew@moqod.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal 
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
// of the Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all 
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
//

#import "QRCodeGenerator.h"
#import "qrencode.h"
#include "zlib.h"

const int MAX_CONTENT_LENGTH = 50 * 1024; // 50K

enum {
	qr_margin = 3
};

@implementation QRCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
	unsigned char *data = 0;
	int width;
	data = code->data;
	width = code->width;
	float zoom = (double)size / (code->width + 2.0 * qr_margin);
	CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
	
	// draw
	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
	for(int i = 0; i < width; ++i) {
		for(int j = 0; j < width; ++j) {
			if(*data & 1) {
				rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
				CGContextAddRect(ctx, rectDraw);
			}
			++data;
		}
	}
	CGContextFillPath(ctx);
}

- (UIImage *)qrImageForString:(const char *)string inputLength:(unsigned long)inputLength imageSize:(CGFloat)size {

    size_t len = strlen(string);
	if (!len) {
		return nil;
	}
    
//    unsigned char dest[1024];
//    unsigned long abb = 1024;
//    int result = gzipCompress((unsigned char *)string, dest, (unsigned int)inputLength, &abb);
//    if (result == 1) {
//        ///
//        //memcpy((void *)tempChar, dest, abb);
//    }
//	
//    NSLog(@"result=%d --abb = %ld",result, abb);//(const char *)dest
    QRcode *code = QRcode_encodeString8bit(string, 0, QR_ECLEVEL_Q); //QRcode_encodeString(string, 0, QR_ECLEVEL_L, QR_MODE_8, 1);
	if (!code) {
		return nil;
	}
	
	// create context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
	
	CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
	CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
	CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
	
	// draw QR on this context	
	[QRCodeGenerator drawQRCode:code context:ctx size:size];
	
	// get image
	CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
	UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
	
	// some releases
	CGContextRelease(ctx);
	CGImageRelease(qrCGImage);
	CGColorSpaceRelease(colorSpace);
	QRcode_free(code);
	
	return qrImage;
}


/**
 *
 * @param source    原压缩内容的指针
 * @param dest  将要解压到的buffer的指针
 * @param destBufferSize    将要解压到的buffer的大小
 * @param inputLength   原压缩内容的长度
 * @param outputLength  解压后内容的长度
 * @return  Z_OK(0)为解压正确
 */
int gzipExpand(unsigned char *source, unsigned char *dest,
               unsigned int bufferSize, unsigned int inputLength,
               unsigned long * outputLength)
{
    int ret = 0;
    z_stream d_stream;
    
    d_stream.zalloc = (alloc_func) NULL;
    d_stream.zfree = (free_func) NULL;
    d_stream.opaque = (voidpf) NULL;
    d_stream.next_in = (Bytef*) source;
    d_stream.avail_in = inputLength;
    d_stream.next_out = (Bytef*) dest;
    d_stream.avail_out = bufferSize;
    
    ret = ::inflateInit2(&d_stream, 47);
    if (ret != 0)
    {
        return ret;
    }
    
    while (ret == Z_OK)
    {
        ret = ::inflate(&d_stream, Z_NO_FLUSH );
        if (ret == Z_STREAM_END) break;
        else if (ret != 0)
        {
            return ret;
        }
    }
    ret = ::inflateEnd(&d_stream);
    if (ret != 0)
    {
        return ret;
    }
    *outputLength = d_stream.total_out;
    
    return Z_OK;
}

/**
 *
 * @param source    原内容的指针
 * @param dest  将要压缩到的buffer的指针
 * @param inputLength   原内容的长度
 * @param outputLength  压缩后内容的长度
 * @return  Z_OK(0)为解压正确
 */
int gzipCompress(unsigned char *source, unsigned char *dest,
                 unsigned int inputLength, unsigned long * outputLength)
{
    static const unsigned char
    gzHeader[10] = { 0x1f, 0x8b, Z_DEFLATED, 0, 0, 0, 0, 0, 0, 3 };
    static const int iCOMPRESS_LEN = ::MAX_CONTENT_LENGTH;
    z_stream c_stream;
    int err = 0;
    unsigned char compressContent[iCOMPRESS_LEN] = { 0 };
    unsigned long contentLen = 0;
    if (source && (inputLength > 0))
    {
        c_stream.zalloc = (alloc_func) 0;
        c_stream.zfree = (free_func) 0;
        c_stream.opaque = (voidpf) 0;
        if (::deflateInit2(&c_stream, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
                           -15, MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY) != Z_OK) return -1;
        c_stream.next_in = (Bytef*) source;
        c_stream.avail_in = inputLength;
        c_stream.next_out = (Bytef*) compressContent;
        c_stream.avail_out = iCOMPRESS_LEN;
        while ((c_stream.avail_in != 0) && (c_stream.total_out < *outputLength))
        {
            if (::deflate(&c_stream, Z_NO_FLUSH) != Z_OK) return -1;
        }
        if (c_stream.avail_in != 0) return c_stream.avail_in;
        for (; ; )
        {
            if ((err = ::deflate(&c_stream, Z_FINISH)) == Z_STREAM_END) break;
            if (err != Z_OK) return -1;
        }
        if (::deflateEnd(&c_stream) != Z_OK) return -1;
        contentLen = c_stream.total_out;
        memcpy(dest, gzHeader, 10);
        memcpy(dest + 10, compressContent, contentLen);
        unsigned long crc = ::crc32(0L, Z_NULL, 0);
        crc = ::crc32(crc, source, inputLength);
        memcpy(dest + 10 + contentLen, &crc, 4);
        memcpy(dest + 10 + contentLen + 4, &inputLength, 4);
        *outputLength = 10 + contentLen + 4 + 4;
        
        return Z_OK;
    }
    return -1;
}

//
//- (const char *)dddSoucre:(const char *)source inputLength:(unsigned long)inputLength
//{
//    unsigned char dest[1024];
//    unsigned long abb = 0;
//    
//    char tempChar[1024];
//    int result = gzipCompress((unsigned char *)source, dest, inputLength, &abb);
//    if (result == 0) {
//        ///
// 
//        memcpy((void *)tempChar, dest, abb);
//    }
//    
//    const char * resultChar  = tempChar;
//    return resultChar;
//}


@end
