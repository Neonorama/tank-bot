//
//  AJBotTurret.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface AJBotTurret : NSObject

@property (nonatomic, assign) AJTurretType turretType;
@property (nonatomic, assign) float orientation;
@property (nonatomic, assign) float energy;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int charges;

+ (id) defaultBotTurret;

- (void) fire;
- (void) turnTurret:(float) angle;
- (void) turnTurretLeft:(float) angle;
- (void) turnTurretRight:(float) angle;

@end
