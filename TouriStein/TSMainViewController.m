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
#import "TSHealthModel.h"

@interface TSMainViewController ()

@property TSAvatarViewController *avatarViewController;
@property TSMapViewController *mapViewController;
@property TSCameraViewController *cameraViewController;

@property (nonatomic, strong) UIView *flashView;

@end

@implementation TSMainViewController

- (id)init
{
    self = [super init];
    if(self){
        [TSHealthModel sharedInstance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(healthDidChange:) name:TSHealthDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    self.flashView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.flashView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
}

- (void)healthDidChange:(NSNotification *)notification
{
    NSInteger oldHealth = [notification.object integerValue];
    NSInteger change = [[TSHealthModel sharedInstance] healthLevel] - oldHealth;
    
    [self setFlashColorForChange:change];
    [self flash];
}


- (void)flash
{
    _flashView.alpha = 0.3;
    self.flashView.frame = self.view.bounds;
    [self.view addSubview:_flashView];
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _flashView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _flashView.alpha = 0;
        } completion:^(BOOL finished) {
            [_flashView removeFromSuperview];
            _flashView.alpha = 0.3;
        }];
    }];
}

- (void)setFlashColorForChange:(NSInteger)change
{
    if(change > 0)
        _flashView.backgroundColor = [UIColor whiteColor];
    else {
        _flashView.backgroundColor = [UIColor redColor];
    }
}



@end
