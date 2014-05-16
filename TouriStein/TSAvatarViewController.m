//
//  TSAvatarViewController.m
//  TouriStein
//
//  Created by Adriaan Stellingwerff on 16/05/2014.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSAvatarViewController.h"
#import "TSHealthModel.h"
#import <AVFoundation/AVFoundation.h>

@interface TSAvatarViewController ()

@property (nonatomic, strong) TSHealthModel *model;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIView *flashView;


@end

@implementation TSAvatarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.model = [TSHealthModel new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(healthDidChange:) name:TSHealthDidChangeNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.avatarView = [[UIImageView alloc] initWithImage:[_model avatarImage]];
    [self.view addSubview:_avatarView];
    
    self.flashView = [[UIView alloc] initWithFrame:self.view.bounds];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(simulateHealthEvent:) userInfo:nil repeats:YES];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)flash
{
    _flashView.alpha = 0.7;
    [self.view addSubview:_flashView];
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _flashView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _flashView.alpha = 0;
        } completion:^(BOOL finished) {
            [_flashView removeFromSuperview];
            _flashView.alpha = 0.7;
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

- (void)playSoundForChange:(NSInteger)change
{
    NSString *soundName = [_model soundNameForHealthChange:change];
    
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : soundName ofType :@"wav"];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

- (void)healthDidChange:(NSNotification *)notification
{
    self.avatarView.image = [_model avatarImage];
    
    NSInteger oldHealth = [notification.object integerValue];
    NSInteger change = [_model healthLevel] - oldHealth;
    
    [self setFlashColorForChange:change];
    [self flash];
    
    //play sound
    [self playSoundForChange:change];
}



- (void)simulateHealthEvent:(NSTimer *)timer
{
    CGFloat value = arc4random() % 100;
    if(value < 10){
        [self.model bigHit];
    } else if(value < 15){
        [self.model bigRecharge];
    } else if(value < 20){
        [self.model smallRecharge];
    } else {
        [self.model smallHit];
    }
    
}

@end
