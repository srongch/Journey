//
//  MyLocation.m
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CarPoint.h"

@interface CarPoint ()
@property (nonatomic, copy) NSString *fleetType;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation CarPoint

-(id)initFleetType:(NSString *)fleetType coordinate:(CLLocationCoordinate2D)coordinate{
    if ((self = [super init])) {
        self.fleetType = fleetType;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return @"";
}

- (NSString *)subtitle {
    return @"";
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

-(NSString *)getFleetType{
    return _fleetType;
}


@end


