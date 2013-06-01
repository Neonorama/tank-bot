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
        self.turret.stateController = self;
        self.chassis    = [AJBotChassis defaultBotChassis];
        self.chassis.stateController = self;
        self.energy     = self.turret.energy + self.chassis.energy;
        self.fuel       = DEFAULT_FUEL;
        self.position   = CGPointMake(0.0, 0.0);
    }
    return self;
}

#pragma mark - Implementation chassis methods

- (void) moveForward:(NSNumber*) distance {
    [self.chassis moveChassisForward:[distance intValue]];
}

- (void) moveBackward:(NSNumber *) distance {
    [self.chassis moveBackward:[distance intValue]];
}

- (void) turn:(NSNumber *) angle {
    [self.chassis turn:[angle intValue]];
}

- (void) turnLeft:(NSNumber *) angle {
    [self.chassis turnLeft:[angle intValue]];
}

- (void) turnRight:(NSNumber *) angle {
    [self.chassis turnRight:[angle intValue]];
}

#pragma mark - Implementation turret methods

- (void) fire {
    [self.turret fire];
}

- (void) turnTurret:(NSNumber *) angle {
    [self.turret turnTurret:[angle intValue]];
}

- (void) turnTurretLeft:(NSNumber *) angle {
    [self.turret turnTurretLeft:[angle intValue]];
}

- (void) turnTurretRight:(NSNumber *) angle {
    [self.turret turnTurretRight:[angle intValue]];
}

#pragma mark - Bot state protocol

-(void)setNewPosition:(CGPoint)newPosition {
    self.position = newPosition;
    [self.turret changePosition:newPosition];
}

-(void)setNewOrientation:(int)newOrientation {
    [self.turret changeOrientation:newOrientation];
}

@end
