//
//  HHToast.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/9.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


typedef enum NSInteger{
    toastDirectTop = 0,
    toastDirectCenter,
    toastDirectBottom
} toastDirect;

@interface HHToast : NSObject

//提示显示(中间、默认时间)
+(void)showTextToast:(NSString*)text;

//提示显示 默认时间
+(void)showTextToast:(NSString*)text direct:(toastDirect)direct;

//自定义显示时间
+(void)showTextToast:(NSString*)text duration:(CGFloat)duration direct:(toastDirect)direct;


//自定义显示时间和距上或距下距离
+(void)showTextToast:(NSString*)text duration:(CGFloat)duration direct:(toastDirect)direct offset:(CGFloat)offset;

@end


