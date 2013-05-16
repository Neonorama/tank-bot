//
//  AJBotChassis.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface AJBotChassis : NSObject

@property (nonatomic, assign) AJChassisType chassisType;
@property (nonatomic, assign) float orientation;
@property (nonatomic, assign) float energy;
@property (nonatomic, assign) CGPoint position;

+ (id) defaultBotChassis;

- (void) moveForward:(float) distance;
- (void) moveBackward:(float) distance;
- (void) turn:(float) angle;
- (void) turnLeft:(float) angle;
- (void) turnRight:(float) angle;

@end
