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
        self.orientation = 0.0f;
        self.energy = DEFAULT_TURRET_ENERGY;
        self.turretType = kTurretTypeCannon;
        self.position   = CGPointMake(0.0, 0.0);
        self.charges = DEFAULT_TURRET_CHARGES;
    }
    return self;
}

- (void) fire {
    
}

- (void) turnTurret:(float) angle {
    
}

- (void) turnTurretLeft:(float) angle {
    
}

- (void) turnTurretRight:(float) angle {
    
}

@end
