//
//  TakeInSecretVC.h
//  Play
//
//  Created by haohao on 16/7/27.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getTakeImgDelegate <NSObject>

-(void)getTakeInSecretImg:(UIImage*)img;

@end

@interface TakeInSecretVC : NSObject

/** 代理 */
@property(nonatomic,strong) id<getTakeImgDelegate> takeInSecretDelegate;

//是否保存到相册
@property(nonatomic,assign) BOOL saveToAblum;

+ (instancetype)sharedInstance;

- (void)startTakePhoto;
- (void)stopTakePhoto;

@end
