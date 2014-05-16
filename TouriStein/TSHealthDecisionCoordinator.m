//
//  TSHealthDecisionCoordinator.m
//  TouriStein
//
//  Created by Adriaan Stellingwerff on 16/05/2014.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSHealthDecisionCoordinator.h"
#import "TSHealthModel.h"

@interface TSHealthDecisionCoordinator ()

@property (nonatomic, assign) BOOL shouldStopTimer;
@property (nonatomic, assign) BOOL userIsUsingCamera;
@property (nonatomic, assign) BOOL userIsSmiling;

@end

@implementation TSHealthDecisionCoordinator


#pragma mark - TSMapViewControllerDelegate methods

- (void)mapViewControllerDidEnterTouristArea:(TSMapViewController *)mapViewController
{
    self.shouldStopTimer = NO;
    [self startTimer];
    
}

- (void)mapViewControllerDidLeaveTouristArea:(TSMapViewController *)mapViewController
{
    self.shouldStopTimer = YES;
}

- (void)mapViewControllerFoundMediKit:(TSMapViewController *)mapViewController
{
    [[TSHealthModel sharedInstance] bigRecharge];
}


#pragma mark - Private methods

- (void)startTimer
{
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
}

- (void)timerDidFire:(NSTimer *)timer
{
    if(self.shouldStopTimer){
        [timer invalidate];
    } else {
        //is user using camera and not smiling?
        if(_userIsUsingCamera && !_userIsSmiling)
            return;
        
        [[TSHealthModel sharedInstance] smallHit];
    }
}

@end
