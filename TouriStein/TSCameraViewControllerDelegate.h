//
//  TSCameraViewControllerDelegate.h
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSCameraViewController;

@protocol TSCameraViewControllerDelegate <NSObject>

@optional

- (void)cameraViewControllerDidDetectHappyTourist:(TSCameraViewController *)controller;
- (void)cameraViewControllerDidDetectSadTourist:(TSCameraViewController *)controller;

- (void)cameraViewControllerFaceDidAppear:(TSCameraViewController *)controller;
- (void)cameraViewControllerFaceDidDisappear:(TSCameraViewController *)controller;


@end
