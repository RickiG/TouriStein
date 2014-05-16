//
//  TSHealthModel.m
//  TouriStein
//
//  Created by Adriaan Stellingwerff on 16/05/2014.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSHealthModel.h"

@interface TSHealthModel ()

@property (nonatomic, assign) NSUInteger health;

@end

@implementation TSHealthModel

- (id)init
{
    self = [super init];
    if(self){
        _health = 100;
    }
    return self;
}

- (NSInteger)healthLevel
{
    return _health;
}

- (void)smallHit
{
    [self decreaseHealthBy:1];
}

- (void)bigHit
{
    [self decreaseHealthBy:5];
}

- (void)smallRecharge
{
    [self increaseHealthBy:5];
}

- (void)bigRecharge
{
    [self increaseHealthBy:20];
}

- (UIImage *)avatarImage
{
    CGFloat interval = 100/7.0f;
    
    if(_health < 0.5* interval)
        return [UIImage imageNamed:@"health0"];
    else if(_health < 1.5 *interval)
        return [UIImage imageNamed:@"health1"];
    else if(_health < 2.5 *interval)
        return [UIImage imageNamed:@"health2"];
    else if(_health < 3.5 *interval)
        return [UIImage imageNamed:@"health3"];
    else if(_health < 4.5 *interval)
        return [UIImage imageNamed:@"health4"];
    else if(_health < 5.5 *interval)
        return [UIImage imageNamed:@"health5"];
    else if(_health < 6.5 *interval)
        return [UIImage imageNamed:@"health6"];
    else
        return [UIImage imageNamed:@"health7"];
}

- (NSString *)soundNameForHealthChange:(NSInteger)change
{
    if(_health == 0)
        return @"dspldeth";
    
    if(change == -1)
        return @"dsoof";
    
    if(change == -5)
        return @"dsplpain";
    
    if(change > 0)
        return @"dsgetpow";
    
    return nil;
}


#pragma mark - Private methods

- (void)decreaseHealthBy:(NSUInteger)hit
{
    if(_health == 0)
        return;
    
    NSInteger oldHealth = _health;
    _health = MAX(0,_health - hit);
    [[NSNotificationCenter defaultCenter] postNotificationName:TSHealthDidChangeNotification object:[NSNumber numberWithInteger:oldHealth] userInfo:nil];
}

- (void)increaseHealthBy:(NSUInteger)recharge
{
    if(_health == 100)
        return;
    
    NSInteger oldHealth = _health;
    _health = MIN(100 ,_health + recharge);
    [[NSNotificationCenter defaultCenter] postNotificationName:TSHealthDidChangeNotification object:[NSNumber numberWithInteger:oldHealth] userInfo:nil];
}

@end
