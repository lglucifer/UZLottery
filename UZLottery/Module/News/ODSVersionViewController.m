//
//  ODSVersionViewController.m
//  OneDaySeries
//
//  Created by TaoXinle on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSVersionViewController.h"
#import <MessageUI/MessageUI.h>
#import "OSDWebViewController.h"
#import "sys/utsname.h"
@interface ODSVersionViewController ()<MFMailComposeViewControllerDelegate>
{
//    UIImageView * bgImgV;
}
@end

@implementation ODSVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"版本信息";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 54.f, 40.f);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50.f - 20.f);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2.f, 0, 0);
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *  backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;

    
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-80)/2.0f,40, 80, 80)];
    logImageView.image = [UIImage imageNamed:@"AppIcon60x60"];
    [self.view addSubview:logImageView];
    logImageView.layer.cornerRadius = 10;
    logImageView.layer.masksToBounds = YES;
    

    
    NSString *logStr = [NSString stringWithFormat:@"%@ %@",CurrentAPPName,CurrentVersion];
    UILabel *logLable = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-160)/2.0f, 40+80+30, 160, 30)];
    logLable.textColor = [UIColor lightGrayColor];
    logLable.font = [UIFont systemFontOfSize:16];
    logLable.backgroundColor = [UIColor clearColor];
    [logLable setTextAlignment:NSTextAlignmentCenter];
    logLable.text = logStr;
    [self.view addSubview:logLable];

    
    UIImageView *topMiddleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2.0f,kScreenHeight - 290 , 280, 1)];
    topMiddleImageView.backgroundColor = [UIColor colorWithHexString:@"#dadbdb"];
//    topMiddleImageView.image = [UIImage imageNamed:@"secion_c_Line.png"];
    [self.view addSubview:topMiddleImageView];
    
    UIImageView *topBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2.0f,kScreenHeight - 240 , 280, 1)];
//    topBottomImageView.image = [UIImage imageNamed:@"secion_c_Line.png"];
    topBottomImageView.backgroundColor = [UIColor colorWithHexString:@"#dadbdb"];
    [self.view addSubview:topBottomImageView];
    
    
    
    UILabel *phoneLable = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2.0f, kScreenHeight - 280, 100, 30)];
    phoneLable.textColor = [UIColor lightGrayColor];
    phoneLable.font = [UIFont systemFontOfSize:14];
    phoneLable.backgroundColor = [UIColor clearColor];
    phoneLable.text = @"意见反馈";
    [self.view addSubview:phoneLable];
    
    
    UIButton *phoneNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth-280)/2.0f-180, kScreenHeight - 280, 180, 30)];
    [phoneNumBtn setTitleColor:[UIColor colorWithRGB:0x03225C] forState:UIControlStateNormal];
    phoneNumBtn.titleLabel.font= [UIFont systemFontOfSize:14];
    phoneNumBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [phoneNumBtn setTitle:@"点击这里反馈意见" forState:UIControlStateNormal];
    [phoneNumBtn addTarget:self action:@selector(suggestionVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumBtn];
    
    
//    UILabel *bottomLable = [[UILabel alloc] initWithFrame:CGRectMake((ODSScreenWidth-260)/2, ODSScreenHeight - 210, 260, 20)];
//    bottomLable.textColor = [UIColor lightGrayColor];
//    bottomLable.font = [UIFont systemFontOfSize:14];
//    bottomLable.backgroundColor = [UIColor clearColor];
//    bottomLable.textAlignment = NSTextAlignmentCenter;
//    bottomLable.text =[[NSString stringWithFormat:@"版权所有:%@",CurrentAPPName] s2tChinese];
//    [self.view addSubview:bottomLable];
    
//    UIButton * kaiyuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [kaiyuanBtn setFrame:CGRectMake((ODSScreenWidth-260)/2, ODSScreenHeight - 210, 260, 30)];
//    [kaiyuanBtn setBackgroundColor:[UIColor clearColor]];
//    [kaiyuanBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [self.view addSubview:kaiyuanBtn];
//    [kaiyuanBtn setTitle:[@"开源组件" s2tChinese] forState:UIControlStateNormal];
//    [kaiyuanBtn setTitleColor:[UIColor colorWithRed:0.027 green:0.58 blue:0.757 alpha:0.8] forState:UIControlStateNormal];
//    [kaiyuanBtn addTarget:self action:@selector(toKaiyuanPage) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton * adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [adBtn setFrame:CGRectMake((ODSScreenWidth-260)/2, ODSScreenHeight - 150, 260, 30)];
//    [adBtn setBackgroundColor:[UIColor colorWithRed:0.027 green:0.58 blue:0.757 alpha:0.8]];
//    [adBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [self.view addSubview:adBtn];
//    adBtn.layer.cornerRadius = 5;
//    adBtn.layer.masksToBounds = YES;
//    [adBtn setTitle:[@"制作团队" s2tChinese] forState:UIControlStateNormal];
//    [adBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [adBtn addTarget:self action:@selector(checkNewVerison) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}
-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)checkNewVerison
//{
//    OSDWebViewController * webV = [[OSDWebViewController alloc] init];
//    webV.title = [@"制作团队";
//    webV.urlStr = @"http://uzero.cn/ipoem/aboutus.html";
//    [self.navigationController pushViewController:webV animated:YES];
//}

-(void)suggestionVC
{
    OSDWebViewController *webVC = [[OSDWebViewController alloc] init];
    webVC.title = @"意见反馈";
    webVC.urlStr = @"http://form.mikecrm.com/atdxdE";
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

//- (void)mailClick
//{
//
//    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
//    
//    if (mailClass != nil)
//    {
//        if ([mailClass canSendMail])
//        {
//            [self displayComposerSheet];
//        }
//        else
//        {
//            [self launchMailAppOnDevice];
//        }
//    }
//    else
//    {
//        [self launchMailAppOnDevice];
//    }
//    
//    
//}

////可以发送邮件的话
//-(void)displayComposerSheet
//{
//    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
//    
//    mailPicker.mailComposeDelegate = self;
//    
//    //设置主题
//    [mailPicker setSubject: @"意见反馈"];
//    
//    // 添加发送者
//    NSArray *toRecipients = [NSArray arrayWithObject: ContactMail];
//    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
//    [mailPicker setToRecipients: toRecipients];
//    //[picker setCcRecipients:ccRecipients];
//    //[picker setBccRecipients:bccRecipients];
//    
//    // 添加图片
//    
//    NSString * sysv = [UIDevice currentDevice].systemVersion;
//    NSString * sysVersion = [NSString stringWithFormat:@"iOS %@",sysv];
//    
//    NSString * deviceModel = [self deviceVersion];
//    
//    NSString *emailBody = [NSString stringWithFormat:@"\n\n\n系统版本：%@\n手机型号：%@\nAPP版本号：%@\n",sysVersion,deviceModel,CurrentVersion];
//    [mailPicker setMessageBody:emailBody isHTML:NO];
//    
//    [self presentViewController:mailPicker animated:YES completion:^{
//        
//    }];
//}
//-(void)launchMailAppOnDevice
//{
//    NSString *recipients = [NSString stringWithFormat:@"mailto:%@",ContactMail];
//
//    
//    NSString *email = [NSString stringWithFormat:@"%@", recipients];
//    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
//    
//}
//- (void)mailComposeController:(MFMailComposeViewController *)controller
//          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{
//    //    NSString *msg;
//    
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//        {
//            [controller dismissViewControllerAnimated:YES completion:^{
//                //                [hud hide:YES];
//                //                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//            break;
//        case MFMailComposeResultSaved:
//        {
//            [controller dismissViewControllerAnimated:YES completion:^{
//                //                [hud hide:YES];
//                //                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//            break;
//        case MFMailComposeResultSent:
//        {
//            [controller dismissViewControllerAnimated:YES completion:^{
//                //                [hud hide:YES];
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//            break;
//        case MFMailComposeResultFailed:
//        {
//            [controller dismissViewControllerAnimated:YES completion:^{
//                //                [hud hide:YES];
//                //                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//            break;
//        default:
//            break;
//    }
//    
//    //    [controller dismissViewControllerAnimated:YES completion:^{
//    //        [hud hide:YES];
//    //        [self.navigationController popViewControllerAnimated:YES];
//    //    }];
//}
//
//-(void)toKaiyuanPage
//{
//    OSDWebViewController *webVC = [[OSDWebViewController alloc] init];
//    webVC.urlStr = @"http://uzero.cn/ipoem/ios_opensource.html";
//    [self.navigationController pushViewController:webVC animated:YES];
//}
//

- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    //iPod
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    //iPad
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7 inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7 inch)";
    
    //Simulator
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
