//
//  StatisticViewController.m
//  freelance
//
//  Created by Chhem Sronglong on 30/09/2017.
//
//https://gist.github.com/swarut/4059530

#import "MapViewController.h"
#import "Journey-Swift.h"
#import <MapKit/MapKit.h>
#import "CarPoint.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController () <MapLoadingProtocol,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) MapViewModelObj *viewModelObj;

@end

@implementation MapViewController



-(void)viewModelObj:(MapViewModelObj *)viewModel{
    self.viewModelObj = viewModel;
    self.viewModelObj.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureMap];
    
}
//52.9284493,-1.488964
-(void)configureMap{
    
    _mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 52.937693; //Derby University
    zoomLocation.longitude= -1.498249;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.7*METERS_PER_MILE, 0.7*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
}

//south west  = point 1
//north east = point 2

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"map will change");
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"map did change");
    [self.viewModelObj setMapBound:mapView.visibleMapRect];
}

-(void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView{
    NSLog(@"mapViewDidChangeVisibleRegion");
//    NSLo")
//    this one is continouse, we don need that
}

- (void)refresh {
    // remove previous annotation
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
}

- (void)error:(NSString * _Nonnull)error {
    //
}


- (void)addPointtoMapWithCarPoint:(CarPoint * _Nonnull)carPoint{
    [_mapView addAnnotation:carPoint];
    
}

- (void)finish:(NSInteger)pointCount {
    //
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"Journey";
    if ([annotation isKindOfClass:[CarPoint class]]) {
        
        CarPoint *point = annotation;
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            
            if ([[point getFleetType] isEqualToString:@"POOLING"]) {
                annotationView.image = [UIImage imageNamed:@"car_map"];
            }else{
                annotationView.image = [UIImage imageNamed:@"002-taxi"];
                
            }
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
