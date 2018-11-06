//
//  HHValidLocalAuthManager.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/5.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getAuthResultBlock)(BOOL result,NSError* error    );

@interface HHValidLocalAuthManager : NSObject

+(instancetype)shareInstance;

-(void)getAuthResult:(getAuthResultBlock)block;

@end
 
