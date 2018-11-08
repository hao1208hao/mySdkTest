//
//  HHUseInfo.m
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "HHUseInfo.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation HHUseInfo

// 系统版本号
+(NSString*)getSystemVersion
{
    NSString* result=@"";
    result=[[UIDevice currentDevice] systemVersion];
    return result;
}

/* 获取应用版本 */
+ (NSString*)getAppVersion
{
    NSString* result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return result;
}

// md5加密
+ (NSString*)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

// 手机设备号
+(NSString*)getDeviceID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获得设备型号
+ (NSString *)getDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    //随着新设备的不断出现，这里已经不止这么多了。
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7plus";
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([platform isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone_X";

    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([platform isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

// 终端信息
+(NSString*)getTerminalInfo
{
    UIDevice* device = [UIDevice currentDevice];
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [devProps setObject:[device model] forKey:@"platform"];
    [devProps setObject:[device systemVersion] forKey:@"version"];
    [devProps setObject:[self getDeviceModel] forKey:@"name"];
    
    NSDictionary* terInfo = [NSDictionary dictionaryWithDictionary:devProps];
    
    return [self dictToJson:terInfo];
}

+(BOOL)isNetworkUseful{
    NSString* currentNetType = [self getNetType];
    if ([currentNetType isEqualToString:@"none"]) {
        return NO;
    }
    return YES;
}

/** 获取网络类型 */
+(NSString*)getNetType{
    NSString* netType = @"none";
    if ([self isReachableViaWWAN]) {
        netType = @"mobile";
    }
    else if([self isReachableViaWiFi]){
        netType = @"wifi";
    }
    return netType;
}

+(BOOL)isReachableViaWiFi
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [@"client.qiandai.com" UTF8String]);
    if(SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        // Check we're reachable
        if((flags & kSCNetworkReachabilityFlagsReachable))
        {
#if    TARGET_OS_IPHONE
            // Check we're NOT on WWAN
            if((flags & kSCNetworkReachabilityFlagsIsWWAN))
            {
                CFRelease(reachabilityRef);
                return NO;
            }
#endif
            CFRelease(reachabilityRef);
            return YES;
        }
    }
    CFRelease(reachabilityRef);
    return NO;
}

+(BOOL)isReachableViaWWAN
{
#if    TARGET_OS_IPHONE
    
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [@"www.baidu.com" UTF8String]);
    if(SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        // Check we're REACHABLE
        if(flags & kSCNetworkReachabilityFlagsReachable)
        {
            // Now, check we're on WWAN
            if(flags & kSCNetworkReachabilityFlagsIsWWAN)
            {
                CFRelease(reachabilityRef);
                return YES;
            }
        }
    }
#endif
    CFRelease(reachabilityRef);
    return NO;
}

/**
 *  字典转json
 *
 *  @param dict 字典
 *
 *  @return 返回转换成的json 数据格式
 */
+(NSString*)dictToJson:(NSDictionary*)dict{
    if (dict == nil) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSArray<NSDictionary*>*)jsonToArray:(NSString *)jsonArrayStr{
    if (!jsonArrayStr.length) return nil;
    NSData * data = [jsonArrayStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        return nil;
    } else {
        return array;
    }
}
  
@end
