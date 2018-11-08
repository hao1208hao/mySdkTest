//
//  HHLocationManager.m
//  HHServiceSDK
//
//  Created by haohao on 2018/11/8.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "HHLocationManager.h"
#import "HHUseInfo.h"
#import "HHMacros.h"

@interface HHLocationManager()<CLLocationManagerDelegate>

/** 定位管理器 */
@property (nonatomic,strong)CLLocationManager* locationManager;
/** 纬度 */
@property (nonatomic,assign)float latitude;
/** 经度 */
@property (nonatomic,assign)float longitude;
/** 高度 */
@property (nonatomic,assign)float altitude;
/** 半径 */
@property (nonatomic,assign)float radius;
/** 国家 */
@property (nonatomic,copy)NSString* country;
/** 国家编码 */
@property (nonatomic,copy)NSString* countryCode;
/** 省份 */
@property (nonatomic,copy)NSString* province;
/** 市 */
@property (nonatomic,copy)NSString* city;
/** 区 */
@property (nonatomic,copy)NSString* district;
/** 详细地址 */
@property (nonatomic,copy)NSString* addr;

@end

@implementation HHLocationManager

SingletonM(Instance);
//懒加载
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

//开启监听
-(void) startLocationMonitor
{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager setDelegate:self];
        self.locationManager.distanceFilter = 10.0f;
        
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self.locationManager requestAlwaysAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
    }else{
        //未开启授权
        HHLog(@"未开启定位授权");
    }
}

//停止定位
-(void)stopLocation{
    [self.locationManager stopUpdatingLocation];
}

//获取位置信息
-(NSString*)getLocationInfo{
    
    NSString* latitudeStr = [NSString stringWithFormat:@"%.4f",self.latitude];
    NSString* longitudeStr = [NSString stringWithFormat:@"%.4f",self.longitude];
    NSString* altitudeStr  = [NSString stringWithFormat:@"%.4f",self.altitude];
    NSString* radiusStr    = [NSString stringWithFormat:@"%.4f",self.radius];
    
    NSString* countryStr = NotNil(self.country);
    NSString* countryCodeStr = NotNil(self.countryCode);
    NSString* provinceStr  =   NotNil(self.province);
    NSString* cityStr      =   NotNil(self.city);
    NSString* districtStr  =   NotNil(self.district);
    NSString* addrStr      =   NotNil(self.addr);
    
    NSDictionary* resultDict=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:longitudeStr,latitudeStr,altitudeStr,radiusStr,countryStr,countryCodeStr,provinceStr,cityStr,districtStr,addrStr,@"", nil] forKeys:[NSArray arrayWithObjects:@"longitude",@"latitude",@"altitude",@"radius",@"country",@"countryCode",@"province",@"city",@"district",@"addr",@"lac",nil]];
    
    return dictToJson(resultDict);
}

//获取经度
-(NSString*)getLongitude{
    NSString* longitudeStr = [NSString stringWithFormat:@"%.4f",self.longitude];
    return longitudeStr;
}

//获取纬度
-(NSString*)getLatitude{
    NSString* latitudeStr = [NSString stringWithFormat:@"%.4f",self.latitude];
    return latitudeStr;
}

#pragma mark - 定位相关
#pragma mark

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.longitude=newLocation.coordinate.longitude;
    self.altitude=newLocation.altitude;
    self.latitude=newLocation.coordinate.latitude;
    self.radius=newLocation.horizontalAccuracy;
    CLLocationCoordinate2D mylocation;
    mylocation.latitude=self.latitude;
    mylocation.longitude=self.longitude;
      
    [self showWithlocation:mylocation];
}

- (void)showWithlocation:(CLLocationCoordinate2D)location {
    
    CLGeocoder* geocoder=[[CLGeocoder alloc]init];
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        
        for (CLPlacemark *placemark in place) {
            self.district=placemark.subLocality;
            NSString *cityStr=[placemark.addressDictionary objectForKey:@"City"];
            self.city=cityStr;
            NSString *country=[placemark.addressDictionary objectForKey:@"Country"];
            self.country = country;
            
            NSString *countryCode=[placemark.addressDictionary objectForKey:@"CountryCode"];
            self.countryCode = countryCode;
            
            NSString *province=[placemark.addressDictionary objectForKey:@"State"];
            self.province=province;
            
            NSArray* array=[placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
            self.addr=[array objectAtIndex:0] ;
            
            break;
            
        }
        if (!error) {
            [self stopLocation];
        }
        
    };
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    
    [geocoder reverseGeocodeLocation:loc completionHandler:handler];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"地理位置授权状态发生变化");
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //打开定位 后重新获取位置
        [self startLocationMonitor];
    }
}

@end
