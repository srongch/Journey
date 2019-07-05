//
//  StatisticViewController.h
//  freelance
//
//  Created by Chhem Sronglong on 30/09/2017.
//

#import <UIKit/UIKit.h>
#import "MapViewModelObj.h"

@class MapViewModel;
@protocol MapLoadingProtocol;

@interface MapViewController : UIViewController

-(void)viewModelObj:(MapViewModelObj *)viewModel;

@end
