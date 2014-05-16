//
//  TSAppDelegate.m
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSCameraController.h"
#import "TSMapViewController.h"
#import "TSAppDelegate.h"
#import "TSAvatarViewController.h"

@implementation TSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *preliminaryViewController = [[UIViewController alloc] init];
    self.window.rootViewController = preliminaryViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TSAvatarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    
    
    [self performSelector:@selector(setupMapViewController) withObject:nil afterDelay:0];
//    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0];
    
    return YES;
}

- (void)setupCamera
{
    self.cameraController = [[TSCameraController alloc] init];
}

- (void) setupMapViewController
{
    TSMapViewController *mapViewController = [[TSMapViewController alloc] init];
    self.window.rootViewController = mapViewController;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
