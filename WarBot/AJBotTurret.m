//
//  AJBotTurret.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJBotTurret.h"

@implementation AJBotTurret

+ (id) defaultBotTurret {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.localOrientation = 0;
        self.absOrientation = 0;
        self.energy = DEFAULT_TURRET_ENERGY;
        self.turretType = kTurretTypeCannon;
        self.position   = CGPointMake(0.0, 0.0);
        self.charges = DEFAULT_TURRET_CHARGES;
    }
    return self;
}

- (void) fire {
    NSLog(@"Fire!");
}

- (void) turnTurret:(int) angle {
    int t = self.localOrientation;
    t += angle % 360;
    if (t <= -180) {
        self.localOrientation = 360 + t;
    } else if (t > 180) {
        self.localOrientation = t - 360;
    } else {
        self.localOrientation = t;
    }
    
    self.absOrientation += angle;
    NSLog(@"Turn turret by %d", angle);
}

- (void) turnTurretLeft:(int) angle {
    int t = self.localOrientation;
    t -= angle % 360;
    if (t < -180) {
        self.localOrientation = 360 + t;
    } else if (t > 180) {
        self.localOrientation = t - 360;
    } else {
        self.localOrientation = t;
    }
    self.absOrientation += angle;
    NSLog(@"Turn turret left by %d", angle);
}

- (void) turnTurretRight:(int) angle {
    int t = self.localOrientation;
    t += angle % 360;
    if (t < -180) {
        self.localOrientation = 360 + t;
    } else if (t > 180) {
        self.localOrientation = t - 360;
    } else {
        self.localOrientation = t;
    }
    self.absOrientation -= angle;
    NSLog(@"Turn turret right by %d", angle);
}

-(void)changeOrientation:(int)newOrientation{
//    self.absOrientation = newOrientation;
}

-(void)changePosition:(CGPoint)newPosition {
//    self.position = newPosition;
}

@end
