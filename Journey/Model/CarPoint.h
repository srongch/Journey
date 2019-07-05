//
//  CarPoint.m
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CarPoint : NSObject <MKAnnotation>

- (id)initFleetType:(NSString*)fleetType coordinate:(CLLocationCoordinate2D)coordinate;
-(NSString *)getFleetType;
@end
