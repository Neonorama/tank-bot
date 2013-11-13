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

@interface AJBot : NSObject <AJBotStateProtocol, NSCopying>

@property (nonatomic, assign) int energy;
@property (nonatomic, assign) int fuel;
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, retain) AJBotTurret *turret;
@property (nonatomic, retain) AJBotChassis *chassis;

@property (nonatomic, assign) id stateController;
@property (nonatomic, weak) id view;

+ (id) defaultBot;

// Chassis methods
- (void) moveForward:(NSNumber *) distance;
- (void) moveBackward:(NSNumber *) distance;
- (void) turn:(NSNumber *) angle;
- (void) turnLeft:(NSNumber *) angle;
- (void) turnRight:(NSNumber *) angle;

// Turret methods
- (void) fire;
- (void) turnTurret:(NSNumber *) angle;
- (void) turnTurretLeft:(NSNumber *) angle;
- (void) turnTurretRight:(NSNumber *) angle;

@end
