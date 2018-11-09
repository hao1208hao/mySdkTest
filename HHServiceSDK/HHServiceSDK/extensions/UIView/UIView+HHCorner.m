//
//  UIView+HHCorner.m
//  HHServiceSDK
//
//  Created by haohao on 2018/11/9.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "UIView+HHCorner.h"
#import <objc/runtime.h>

static NSString * const kcornerRadii = @"cornerRadi";
static NSString * const krectCorner = @"cornerDirect";


@implementation UIView (HHCorner)

- (void)setCornerRadii:(CGFloat)cornerRadii{
    CGFloat Radii = [objc_getAssociatedObject(self, &kcornerRadii) floatValue];
    if (Radii != cornerRadii) {
        [self willChangeValueForKey:kcornerRadii];
        objc_setAssociatedObject(self, &kcornerRadii,
                                 @(cornerRadii),
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:kcornerRadii];
        [self AxcUI_rectCornerWithCornerRadii:cornerRadii Corner:self.cornerDirect];
    }
    
    
}           
- (CGFloat)cornerRadii{
    if (!objc_getAssociatedObject(self, &kcornerRadii)) {
        [self setCornerRadii:5];
    }
    return [objc_getAssociatedObject(self, &kcornerRadii) floatValue];
}

- (void)setCornerDirect:(UIRectCorner)cornerDirect{
    [self willChangeValueForKey:krectCorner];
    objc_setAssociatedObject(self, &krectCorner,
                             @(cornerDirect),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:krectCorner];
    
    [self AxcUI_rectCornerWithCornerRadii:self.cornerRadii Corner:cornerDirect];
}
- (UIRectCorner)cornerDirect{
    return [objc_getAssociatedObject(self, &krectCorner) intValue];
}

- (void)AxcUI_rectCornerWithCornerRadii:(CGFloat )cornerRadii Corner:(UIRectCorner)corner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(cornerRadii,
                                                                                cornerRadii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
