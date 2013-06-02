//
//  AJBotChassis.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJBotChassis.h"

@implementation AJBotChassis

+(id)defaultBotChassis {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.energy = DEFAULT_CHASSIS_ENERGY;
        self.orientation = 0;    // 0-359
        self.chassisType = kChassisTypeWheel;
        self.position   = CGPointMake(0.0, 0.0);
    }
    return self;
}

- (void) moveChassisForward:(int) distance {
    CGPoint t = self.position;
    t.x += round(distance * cosf(self.orientation * M_PI / 180.0));
    t.y += round(distance * -sinf(self.orientation * M_PI / 180.0));
    self.position = t;
    
    [self.stateController setNewPosition:self.position];
    NSLog(@"Move forward by %d", distance);
}

- (void) moveBackward:(int) distance {
    CGPoint t = self.position;
    t.x -= round(distance * cosf(self.orientation * M_PI / 180.0));
    t.y -= round(distance * -sinf(self.orientation * M_PI / 180.0));
    self.position = t;

    [self.stateController setNewPosition:self.position];
    NSLog(@"Move backward by %d", distance);
}

- (void) turn:(int) angle {
    int t = self.orientation;
    t += angle % 360;
    if (t < 0) {
        self.orientation = 360 + t;
    } else if (t >= 360) {
        self.orientation = t - 360;
    } else {
        self.orientation = t;
    }
    
    [self.stateController setNewOrientation:self.orientation];
    NSLog(@"Turn by %d", angle);
}

- (void) turnLeft:(int) angle {
    int t = self.orientation;
    t -= angle % 360;
    if (t < 0) {
        self.orientation = 360 + t;
    } else if (t >= 360) {
        self.orientation = t - 360;
    } else {
        self.orientation = t;
    }

    [self.stateController setNewOrientation:self.orientation];
    NSLog(@"Turn left by %d", angle);
}

- (void) turnRight:(int) angle {
    int t = self.orientation;
    t += angle % 360;
    if (t < 0) {
        self.orientation = 360 + t;
    } else if (t >= 360) {
        self.orientation = t - 360;
    } else {
        self.orientation = t;
    }

    [self.stateController setNewOrientation:self.orientation];
    NSLog(@"Turn right by %d", angle);
}

@end
