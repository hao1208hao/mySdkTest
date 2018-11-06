//
//  HHValidLocalAuthManager.m
//  HHServiceSDK
//
//  Created by haohao on 2018/11/5.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "HHValidLocalAuthManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface HHValidLocalAuthManager()

/** 回调代码块 */
@property (nonatomic, copy) getAuthResultBlock block;

@property (nonatomic, strong) LAContext *context;

@end

@implementation HHValidLocalAuthManager

//初始化
+(instancetype)shareInstance{
    
    static HHValidLocalAuthManager *instance;
    static dispatch_once_t toolOnce;
    dispatch_once(&toolOnce, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}

//懒加载
- (LAContext *)context {
    if (_context == nil) {
        _context = [LAContext new];
    }
    return _context;
}


-(void)getAuthResult:(getAuthResultBlock)block{
    self.block = block;
    
    NSError *error;
    
    if (@available(iOS 9.0, *)) {
        BOOL canAuthentication = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
        
        if (canAuthentication) {
            [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请使用FaceID或指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                
                //注意iOS 11.3之后需要配置Info.plist权限才可以通过Face ID验证哦!不然只能输密码啦...
                self.block(success,error);
            }];
        }
    } else {
        error = [NSError errorWithDomain:@"not support" code:-99 userInfo:nil];
        self.block(false,error);
    }
}

@end
