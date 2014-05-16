//
//  TSMapViewController.h
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSMapViewController;

@protocol TSMapViewControllerDelegate<NSObject>

- (void) mapViewControllerDidEnterTouristArea:(TSMapViewController*) mapViewController;
- (void) mapViewControllerDidLeaveTouristArea:(TSMapViewController*) mapViewController;
- (void) mapViewControllerFoundMediKit:(TSMapViewController*) mapViewController;

@end

@interface TSMapViewController : UIViewController

@property(nonatomic, weak) id<TSMapViewControllerDelegate> delegate;

@end
