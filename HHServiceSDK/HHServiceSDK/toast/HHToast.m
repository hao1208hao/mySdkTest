//
//  HHToast.m
//  HHServiceSDK
//
//  Created by haohao on 2018/11/9.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "HHToast.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.5f

//Toast到顶端/底端默认距离
#define ToastSpace 100.0f

//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]


@interface HHToast ()
{
    UIButton *_contentView;
    CGFloat  _duration;
}
@end

@implementation HHToast

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}


- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 15)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 15.0f;
        _contentView.backgroundColor = ToastBackgroundColor;
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        _duration = ToastDispalyDuration;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify{
    [self hideAnimation];
}

-(void)dismissToast{
    [_contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)show{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = window.center;
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

//距上距离
- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

//距下距离
- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + _contentView.frame.size.height/2));
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

+(void)showTextToast:(NSString*)text{
    [HHToast showTextToast:text direct:toastDirectCenter];
}

//提示显示 默认时间
+(void)showTextToast:(NSString*)text direct:(toastDirect)direct{
    
    if (direct == toastDirectCenter) {
        //中间显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:ToastDispalyDuration];
        [toast show];
    }else if (direct == toastDirectTop){
        //上面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:ToastDispalyDuration];
        [toast showFromTopOffset:ToastSpace];
        
    }else if(direct == toastDirectBottom){
        //下面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:ToastDispalyDuration];
        
        [toast showFromBottomOffset:ToastSpace];
    }
    
}

//自定义显示时间
+(void)showTextToast:(NSString*)text duration:(CGFloat)duration direct:(toastDirect)direct{
    
    if (direct == toastDirectCenter) {
        //中间显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast show];
    }else if (direct == toastDirectTop){
        //上面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast showFromTopOffset:ToastSpace];
        
    }else if(direct == toastDirectBottom){
        //下面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast showFromBottomOffset:ToastSpace];
    }
}
//自定义显示时间和距上或距下距离
+(void)showTextToast:(NSString*)text duration:(CGFloat)duration direct:(toastDirect)direct offset:(CGFloat)offset{
    
    if (direct == toastDirectCenter) {
        //中间显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast show];
    }else if (direct == toastDirectTop){
        //上面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast showFromTopOffset:offset];
        
    }else if(direct == toastDirectBottom){
        //下面显示
        HHToast *toast = [[HHToast alloc] initWithText:text];
        [toast setDuration:duration];
        [toast showFromBottomOffset:offset];
        
    }
    
}
@end
