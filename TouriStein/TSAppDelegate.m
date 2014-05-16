//
//  TSAppDelegate.m
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSCameraController.h"

#import "TSAppDelegate.h"

@implementation TSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *preliminaryViewController = [[UIViewController alloc] init];
    self.window.rootViewController = preliminaryViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0];
    
    return YES;
}

- (void)setupCamera
{
    self.cameraController = [[TSCameraController alloc] init];
}

@end
