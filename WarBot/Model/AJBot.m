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

- (void) moveForward:(int) distance {
    [self.chassis moveForward:distance];
}

- (void) moveBackward:(int) distance {
    [self.chassis moveBackward:distance];
}

- (void) turn:(int) angle {
    [self.chassis turn:angle];
}

- (void) turnLeft:(int) angle {
    [self.chassis turnLeft:angle];
}

- (void) turnRight:(int) angle {
    [self.chassis turnRight:angle];
}

#pragma mark - Implementation turret methods

- (void) fire {
    [self.turret fire];
}

- (void) turnTurret:(int) angle {
    [self.turret turnTurret:angle];
}

- (void) turnTurretLeft:(int) angle {
    [self.turret turnTurretLeft:angle];
}

- (void) turnTurretRight:(int) angle {
    [self.turret turnTurretRight:angle];
}

@end
