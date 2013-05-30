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

@interface AJBot : NSObject <AJBotStateProtocol>

@property (nonatomic, assign) int energy;
@property (nonatomic, assign) int fuel;
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, retain) AJBotTurret *turret;
@property (nonatomic, retain) AJBotChassis *chassis;

@property (nonatomic, assign) id stateController;

+ (id) defaultBot;

// Chassis methods
- (void) moveForward:(NSNumber *) distance;
- (void) moveBackward:(NSNumber *) distance;
- (void) turn:(int) angle;
- (void) turnLeft:(int) angle;
- (void) turnRight:(int) angle;

// Turret methods
- (void) fire;
- (void) turnTurret:(int) angle;
- (void) turnTurretLeft:(int) angle;
- (void) turnTurretRight:(int) angle;

@end
