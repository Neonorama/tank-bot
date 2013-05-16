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
        self.orientation = 0.0f;
        self.chassisType = kChassisTypeWheel;
        self.position   = CGPointMake(0.0, 0.0);
    }
    return self;
}

- (void) moveForward:(float) distance {
    
}

- (void) moveBackward:(float) distance {
    
}

- (void) turn:(float) angle {
    
}

- (void) turnLeft:(float) angle {
    
}

- (void) turnRight:(float) angle {
    
}

@end
