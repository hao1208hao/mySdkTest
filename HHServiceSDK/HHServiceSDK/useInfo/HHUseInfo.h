//
//  HHUseInfo.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUseInfo : NSObject

// 获取系统版本
+(NSString*)getSystemVersion;

// 应用版本
+(NSString*)getAppVersion;

// md5加密
+(NSString*)md5:(NSString *)input;

// 手机设备号
+(NSString*)getDeviceID;

// 获得设备型号
+ (NSString *)getDeviceModel;

// 终端信息
+(NSString*)getTerminalInfo;

// 获取网络类型
+(BOOL)isNetworkUseful;

+(NSString*)getNetType;

// 字典转json
+(NSString*)dictToJson:(NSDictionary*)dict;

/**字典转JSON数组*/
+(NSArray<NSDictionary*>*)jsonToArray:(NSString *)jsonArrayStr;

@end


