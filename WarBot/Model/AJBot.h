//
//  AJBot.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 14.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AJBotChassis.h"
#import "AJBotTurret.h"
#import "Utils.h"

@interface AJBot : NSObject

@property (nonatomic, assign) int energy;
@property (nonatomic, assign) int fuel;
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, retain) AJBotTurret *turret;
@property (nonatomic, retain) AJBotChassis *chassis;

+ (id) defaultBot;

// Chassis methods
- (void) moveForward:(float) distance;
- (void) moveBackward:(float) distance;
- (void) turn:(float) angle;
- (void) turnLeft:(float) angle;
- (void) turnRight:(float) angle;

// Turret methods
- (void) fire;
- (void) turnTurret:(float) angle;
- (void) turnTurretLeft:(float) angle;
- (void) turnTurretRight:(float) angle;

@end
