//
//  TSAppDelegate.h
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSCameraViewController;

@interface TSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property TSCameraViewController *cameraController;

@end
