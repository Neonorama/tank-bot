//
//  AJBot.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 14.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJBot.h"

@implementation AJBot

+ (id) defaultBot {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.turret     = [AJBotTurret defaultBotTurret];
        self.chassis    = [AJBotChassis defaultBotChassis];
        self.energy     = self.turret.energy + self.chassis.energy;
        self.fuel       = DEFAULT_FUEL;
        self.position   = CGPointMake(0.0, 0.0);
    }
    return self;
}

#pragma mark - Implementation chassis methods

- (void) moveForward:(float) distance {
    [self.chassis moveForward:distance];
}

- (void) moveBackward:(float) distance {
    [self.chassis moveBackward:distance];
}

- (void) turn:(float) angle {
    [self.chassis turn:angle];
}

- (void) turnLeft:(float) angle {
    [self.chassis turnLeft:angle];
}

- (void) turnRight:(float) angle {
    [self.chassis turnRight:angle];
}

#pragma mark - Implementation turret methods

- (void) fire {
    [self.turret fire];
}

- (void) turnTurret:(float) angle {
    [self.turret turnTurret:angle];
}

- (void) turnTurretLeft:(float) angle {
    [self.turret turnTurretLeft:angle];
}

- (void) turnTurretRight:(float) angle {
    [self.turret turnTurretRight:angle];
}

@end
