//
//  TSHealthModel.h
//  TouriStein
//
//  Created by Adriaan Stellingwerff on 16/05/2014.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const TSHealthDidChangeNotification = @"TSHealthDidChangeNotification";


@interface TSHealthModel : NSObject

+ (TSHealthModel *)sharedInstance;

- (UIImage *)avatarImage;
- (NSString *)soundNameForHealthChange:(NSInteger)change;

- (void)smallHit;
- (void)bigHit;
- (void)smallRecharge;
- (void)bigRecharge;

- (NSInteger)healthLevel;

@end

