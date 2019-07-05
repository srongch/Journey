//
//  MapViewModelObj.m
//  Journey
//
//  Created by Chhem Sronglong on 25/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapViewModelObj.h"
#import "Journey-Swift.h"
#import "CarPoint.h"

@interface MapViewModelObj()<MapNetworkProtocol>

@property (nonatomic,strong) MapNetwork *mapNetwork;
@property (nonatomic) MKMapRect mapRect;
@property (nonatomic, strong) NSArray *carPoints;

@end

@implementation MapViewModelObj


- (instancetype)initWithMapNetWork:(MapNetwork *)mapNetwork{
    self = [super init];
    if (!self) return nil;
    self.mapNetwork = mapNetwork;
    [self.mapNetwork setDelegate:self];
    return self;
}


-(void)sendToDelegate{
    if([self.delegate respondsToSelector:@selector(refresh)]) {
        [self.delegate refresh];
    }
}

-(void)setMapBound:(MKMapRect )mapRect{
    if (![self isOldRect:self.mapRect isEqual:mapRect]) {
        self.mapRect = mapRect;
        MapBound *calculatedMapBound = [self calculatMapBound:self.mapRect];
       [self.mapNetwork fetchWithMapBound:calculatedMapBound];
        NSLog(@"set new bound");
    }else{
        NSLog(@"bound is the same");
    }
}

-(MKMapRect)getCurrentMapRect{
    return self.mapRect;
}

-(MapBound *)calculatMapBound:(MKMapRect)mapRect {
    MKMapPoint neMapPoint = MKMapPointMake(MKMapRectGetMaxX(mapRect), mapRect.origin.y);
    MKMapPoint swMapPoint = MKMapPointMake(mapRect.origin.x, MKMapRectGetMaxY(mapRect));
    CLLocationCoordinate2D neCoord = MKCoordinateForMapPoint(neMapPoint); // (x2,y2)
    CLLocationCoordinate2D swCoord = MKCoordinateForMapPoint(swMapPoint); // (x1, y1)

    MapBound *mapbound = [[MapBound alloc]initWithLatitude1:swCoord.latitude longtitute1:swCoord.longitude latitude2:neCoord.latitude longtitute2:neCoord.longitude];


    return mapbound;
    
}

-(BOOL)isOldRect:(MKMapRect)oldRect isEqual:(MKMapRect)object{
 return oldRect.size.height == object.size.height &&
    oldRect.size.width == object.size.height &&
    oldRect.origin.x == object.origin.x &&
    oldRect.origin.y == object.origin.y;
}

- (void)finishLoadingWithDataWithItems:(NSArray<MapItem *> * _Nonnull)items{
 
    [self sendToDelegate]; // prepre to remove add previous one
    NSMutableArray *newPoints = [[NSMutableArray alloc] init];
//    newPoints.a
    for (MapItem *row in items) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = row.latitude;
        coordinate.longitude = row.longitude;
        CarPoint *annotation = [[CarPoint alloc]initFleetType:row.fleetType coordinate:coordinate] ;
        if([self.delegate respondsToSelector:@selector(addPointtoMapWithCarPoint:)]) {
            [self.delegate addPointtoMapWithCarPoint:annotation];
        }
        [newPoints addObject:annotation];
    }
    
    //finish
    self.carPoints = newPoints;
    if([self.delegate respondsToSelector:@selector(finish:)]) {
        [self.delegate finish:self.carPoints.count];
    }
}



-(void)error{
    if([self.delegate respondsToSelector:@selector(error)]) {
        [self.delegate error:@""];
    }
}

-(CarPoint *)getCarPointAtIndex:(int)index{
    if (self.carPoints.count > index) {
        return self.carPoints[index];
    }
    return nil;
}


@end
