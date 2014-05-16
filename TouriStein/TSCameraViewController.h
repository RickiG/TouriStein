//
//  TSCameraController.h
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSCameraViewControllerDelegate.h"

@interface TSCameraViewController : UIViewController

@property (weak) id<TSCameraViewControllerDelegate> delegate;

@property (nonatomic) BOOL hasFace;

@end
