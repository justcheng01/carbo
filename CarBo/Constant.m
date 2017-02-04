//
//  Constant.m
//  CarBo
//
//  Created by Shirish Vispute on 26/09/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "Constant.h"

#ifdef DEBUG
NSString *const kAPIEndpointHost = @"http://74.208.12.101/Carboservices/";
#else
NSString *const kAPIEndpointHost = @"http://74.208.12.101/Carboservices/";
#endif

NSString *const kAPIEndpointLatestPath  = @"https://panel.carbo.com.hk/Carboservices/";
NSString *const Kmain                                  = @"#18a967";
NSString *const Kmaincolor                         = @"#28AC70";
NSString *const Klightcolor                          = @"#F8F6F8";

@implementation Constant

@end
