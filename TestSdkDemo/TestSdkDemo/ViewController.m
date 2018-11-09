//
//  ViewController.m
//  TestSdkDemo
//
//  Created by haohao on 2018/11/6.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "ViewController.h"
#import <HHServiceSDK/HHServiceSDK.h>
#import <HHServiceSDK/HHLocationManager.h>
#import <WebKit/WKWebView.h>
#import <HHServiceSDK/WKWebViewVC.h>
#import <HHServiceSDK/HHToast.h>
#import <HHServiceSDK/UIView+HHCorner.h>

//#import "UIView+HHCorner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray* titleArr = @[@"拍照",@"生成二维码",@"扫一扫",@"截屏",@"测试Gzip",@"wkwebView",@"简体转繁体",@"验证码",@"FaceID或者指纹",@"语音转文字"];
    
    int col = 4;//列
    int row = titleArr.count/col; //行
    if (titleArr.count%col>0) {
        row +=1;
    }
    int btnW = 60;//按钮长
    int btnH = 60;//按钮宽
    
    
    //按钮间距
    int left = (SCREEN_WIDTH - col*btnW)/(col+1);
    int padH = (SCREEN_HEIGHT-row*btnH)/(row+1);
    for (int i = 0; i<titleArr.count; i++) {
        /** 需要的按钮 */
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(i%col*btnW+(i%col+1)*left, i/col*btnH+(i/col+1)*padH, btnW, btnH);
        [btn setFrame:frame];
        btn.layer.cornerRadius = 4;
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        NSString* str = [NSString stringWithFormat:@"拍照%d",i];
        //        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
}


-(void)btnClick:(UIButton*)btn{
    NSInteger tag = btn.tag;
    //self.lastTakePicID = tag;
    
    if (tag == 0) {
        //[self take];   //偷拍
        //NSString* locaion = HHGetLocation;
        //HHCommonAlert(locaion);
        
        [HHToast showTextToast:@"这是真的么，我就想试试这是不是真的"];
    }else if(tag == 1){
        
        NSArray* qrArr = @[@"能不能借我 5k 块钱?",@"能不能借我 1w 块钱?",@"能不能借我 1.5w 块钱?",@"能不能借我 2w 块钱?",@"能不能借我 2.5w 块钱?",@"能不能借我 3w 块钱?",@"能不能借我 3.5w 块钱?",@"能不能借我 4w 块钱?",];
        
        int i =  arc4random() % 8;
        NSString* str = qrArr[i];
        
        UIImage* img =[QRTool createQRImgWithContent:str imgSize:200];
        
        /*
         UIImageView* imgV = [[UIImageView alloc]initWithImage:img];
         [imgV setFrame:CGRectMake(50, 100, 200, 200)];
         [self.view addSubview:imgV];
         
        
        HHShowImage2* alert=[[HHShowImage2 alloc] initWithImage:img];
        [alert showInView:[[[UIApplication sharedApplication] windows] lastObject]];
        
        
         //长按手势
         [imgV setUserInteractionEnabled:YES];
         UITapGestureRecognizer* longT = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test:)];
         [longT setNumberOfTouchesRequired:1];
         [imgV addGestureRecognizer:longT];
         
         */
    }else if(tag == 2){
        ScanQR *scan = [[ScanQR alloc]init];
        //scan.scanDelegate = self;
        //        [self presentViewController:scan animated:YES completion:nil];
        
        scan.block = ^(NSString *result) {
            NSLog(@"扫描结果是:============%@",result);
            HHCommonAlert(result);
        };
        
        [self.navigationController pushViewController:scan animated:YES];
    }else if(tag == 3){
        
        WKWebViewVC* wk = [[WKWebViewVC alloc]init];
        /** 往项目中存储了一个网页文件 */
        wk.loadLocalHtmlFile = @"testWKWeb";   //传文件名
        //wk.loadURL = @"http://192.168.208.156/testWKWeb.html";
        //wk.loadURL = @"http://10.23.2.120:81/testWKWeb.html";
        NSMutableArray* arr = [NSMutableArray arrayWithArray:@[@"loginAction",@"closeCurrPage"]];
        wk.jsFunName = arr;
        
        wk.htmlBlock = ^(NSString *functionName, NSMutableDictionary *respDict, WKWebView *wk) {
            if ([functionName isEqualToString:@"loginAction"]) {
                 HHLog(@"functionName is :%@",functionName);
                
            }
        };
        
        [self.navigationController pushViewController:wk animated:YES];
        
    }else if(tag == 4){
        /** 测试Gzip 压缩 */
        
        UIView* view = [[UIView alloc]init];
        [view setFrame:CGRectMake(100, 300, 200, 200)];
        [view setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:view];
        
        view.cornerRadii = 17;
        view.cornerDirect = UIRectCornerAllCorners;
    }else if(tag == 5){
        HHCommonAlert(deviceID);
        
    }else if(tag == 6){
        
    }else if(tag == 7){
        
        
    }else if(tag == 8){
        //FaceID 或 指纹
        [[HHValidLocalAuthManager shareInstance] getAuthResult:^(BOOL result, NSError *error) {
            if(result){
                dispatch_async(dispatch_get_main_queue(), ^{
                HHCommonAlert(@"验证成功");
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    HHCommonAlert(error.localizedDescription);
                });
            }
        }];
        
        
    }else if(tag == 9){
        //语音转文字测试
        //语音文件  url
        /*
         SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
         NSURL *aURL = [NSURL fileURLWithPath:url];
         SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:aURL];
         [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
         if (error) {
         NSLog(@"reconize speech error : %@", error);
         }
         NSLog(@"speech text : %@", result.bestTranscription.formattedString);
         }];
         
         */
        
    }else  if(tag == 10){
        
    }
}


@end
