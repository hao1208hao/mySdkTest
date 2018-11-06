//
//  ViewController.m
//  TestSdkDemo
//
//  Created by haohao on 2018/11/6.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "ViewController.h"
#import <HHServiceSDK/HHServiceSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    ScanQR* scan = [[ScanQR alloc]init];
    
    scan.block = ^(NSString *result) {
        NSLog(@"扫描到的结果是:%@",result);
    };
    
    [self.navigationController pushViewController:scan animated:YES];
    
    */
    
    [[HHValidLocalAuthManager shareInstance] getAuthResult:^(BOOL result, NSError *error) {
        NSLog(@"验证结果:%d",result);
    }];
    
}


@end
