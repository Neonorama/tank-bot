//
//  AJBot.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 14.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Utils.h"
#import <SpriteKit/SpriteKit.h>

@interface AJBot : NSObject

@property (nonatomic, assign) int energy;
@property (nonatomic, assign) int fuel;

@property (nonatomic, retain) SKSpriteNode *chassis;
@property (nonatomic, retain) SKSpriteNode *turret;

//@property (nonatomic, assign) id stateController;
//@property (nonatomic, weak) SKNode *view;

+ (id) defaultBot;
+ (id) botWithChassisName: (NSString *) chassisName andTurretName: (NSString *) turretName;

- (void) initPhysics;

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
