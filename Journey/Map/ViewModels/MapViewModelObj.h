//
//  MapViewModelObj1.m
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
//https://www.objc.io/issues/13-architecture/mvvm/

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@protocol MapLoadingProtocol;
@protocol MapNetworkProtocol;
@class MapNetwork;
@class MapBound;
@class CarPoint;

@interface MapViewModelObj : NSObject

- (instancetype)initWithMapNetWork:(MapNetwork *)mapNetwork;

@property (nonatomic, weak) id <MapLoadingProtocol> delegate;

-(void)setMapBound:(MKMapRect)mapRect;
-(MKMapRect)getCurrentMapRect;
-(MapBound *)calculatMapBound:(MKMapRect)mapRect;
-(CarPoint *)getCarPointAtIndex:(int)index;

@end

