//
//  HHImageCode.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getImageCodeBlock)(NSString* codeStr);

@interface HHImageCode : UIView

+(instancetype)shareImageCode; 

@property (nonatomic, copy) getImageCodeBlock block;
 
@end

