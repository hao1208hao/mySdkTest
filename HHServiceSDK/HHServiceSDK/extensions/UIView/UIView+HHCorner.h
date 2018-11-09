//
//  UIView+HHCorner.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/9.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HHCorner)


/**
 *  圆角半径 默认 5  cornerRadii
 */
@property(nonatomic,assign)CGFloat cornerRadii;

/**
 *  圆角方位  cornerDirect
 */
@property(nonatomic,assign)UIRectCorner cornerDirect;


@end
