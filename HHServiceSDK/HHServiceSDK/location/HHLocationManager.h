//
//  HHLocationManager.h
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HHSingleton.h"

@interface HHLocationManager : CLLocationManager

SingletonH(Instance);

//开始定位
-(void) startLocationMonitor;

//关闭定位
-(void)stopLocation;

//获取位置信息
-(NSString*)getLocationInfo;

//获取经度
-(NSString*)getLongitude;

//获取纬度 
-(NSString*)getLatitude;

@end

