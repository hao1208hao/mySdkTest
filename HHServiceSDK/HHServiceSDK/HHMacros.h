//
//  HHMacros.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef HHMacros_h
#define HHMacros_h


#pragma mark - 辅助方法
#pragma mark -

#define dictToJson(dict) [HHUseInfo dictToJson:dict]
#define jsonToArray(jsonStr) [HHUseInfo jsonToArray:jsonStr]

//如果值为nil 传空
#define NotNil(value) value?:@""
//忽略大小写比较字符串
#define ignoreCompare(str,str2) [str compare:str2                         options:NSCaseInsensitiveSearch ] == NSOrderedSame

#pragma mark - 尺寸相关
#pragma mark -

// 屏幕相关尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//DEBUG  模式下打印日志,当前行

#ifdef DEBUG
//#define HHLog(...) NSLog(__VA_ARGS__)
#define HHLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define HHLog(...)
#endif


// 导航栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)

#define navAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


#define TabbarHeight (SCREEN_HEIGHT == 812.0 ? 83 : 49)

#pragma mark - useInfo 使用相关
#pragma mark -
//获取版本及硬件信息
#define sysVersion [HHUseInfo getSystemVersion]  //获取系统版本
#define appVersion [HHUseInfo getAppVersion]  //appVersion
#define deviceID [HHUseInfo getDeviceID]    //获取手机唯一标识 UUID
#define deviceModel [HHUseInfo getDeviceModel]   // 获取手机类型  iPhone5s
#define terminalInfo [HHUseInfo getTerminalInfo]  //获取终端信息
#define HHNetUseFul [HHUseInfo isNetworkUseful]  //网络是否可用
#define HHNetType [HHUseInfo getNetType]  //获取当前网络连接类型 wifi/4G/3G

#define HHMD5(str) [HHUseInfo md5:str]  //md5
 


#define HHGetLocation [[HHLocationManager sharedInstance] getLocation] //获取定位json串
#define HHGetLongitude [[HHLocationManager sharedInstance] getLongitude]  //获取经度
#define HHGetLatitude [[HHLocationManager sharedInstance] getLatitude]  //获取纬度



#define userDefaults [NSUserDefaults standardUserDefaults]
#define userDefaultsForKey(Key) [[NSUserDefaults standardUserDefaults] objectForKey:Key]

#pragma mark - 颜色相关
#pragma mark -

#define HHRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define HHColorHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0f]

#define HHColorHexA(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:a * 1.0f]


#pragma mark - 系统版本
#pragma mark

// 判断版本是否是7.0及以上
#define iOS7  ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 判断版本是否是8.0及以上
#define iOS8  ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)



#pragma mark - 提示相关
#pragma mark

#define HHAlertView [HHAlert shareHHAlert]

// 提示框alert(带自定义标题)
#define HHAlertWithTitle(_title_, _msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_ message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];

// 提示框alert(带“提示”标题)
#define HHCommonAlert(_msg_) HHAlertWithTitle(@"提示", _msg_)


#endif /* HHMacros_h */
