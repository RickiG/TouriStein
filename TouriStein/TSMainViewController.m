//
//  TSMainViewController.m
//  TouriStein
//
//  Created by Gernot Poetsch on 16.05.14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSAvatarViewController.h"
#import "TSMapViewController.h"
#import "TSCameraViewController.h"

#import "TSMainViewController.h"

@interface TSMainViewController ()

@property TSAvatarViewController *avatarViewController;
@property TSMapViewController *mapViewController;
@property TSCameraViewController *cameraViewController;

@end

@implementation TSMainViewController

- (void)dealloc
{
    [self.cameraViewController removeObserver:self forKeyPath:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapViewController = [[TSMapViewController alloc] init];
    [self addChildViewController:self.mapViewController];
    self.mapViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.mapViewController.view];
    
    self.avatarViewController = [[TSAvatarViewController alloc] init];
    [self addChildViewController:self.avatarViewController];
    self.avatarViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.avatarViewController.view];
    
    self.cameraViewController = [[TSCameraViewController alloc] init];
    [self addChildViewController:self.cameraViewController];
    self.cameraViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cameraViewController.view];
    
    NSDictionary *views = @{@"Map": self.mapViewController.view,
                            @"Avatar": self.avatarViewController.view,
                            @"Camera": self.cameraViewController.view};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[Map]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Map]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[Camera(100)]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[Camera(130)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[Avatar(100)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[Avatar(130)]-|" options:0 metrics:nil views:views]];
    
    [self.cameraViewController addObserver:self forKeyPath:@"hasFace" options:0 context:0];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.cameraViewController && [keyPath isEqualToString:@"hasFace"]) {
        [self updateInterface];
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)updateInterface
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.cameraViewController.view.alpha = (self.cameraViewController.hasFace) ? 0.0 : 1.0;
                     }
                     completion:nil];
}


@end
