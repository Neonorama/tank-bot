//
//  AJBotChassis.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "AJBotStateProtocol.h"

@interface AJBotChassis : NSObject

@property (nonatomic, assign) AJChassisType chassisType;
@property (nonatomic, assign) int orientation; // 0 - 359
@property (nonatomic, assign) int energy;
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, assign) id <AJBotStateProtocol> stateController;

+ (id) defaultBotChassis;

- (void) moveChassisForward:(int) distance;
- (void) moveBackward:(int) distance;
- (void) turn:(int) angle;
- (void) turnLeft:(int) angle;
- (void) turnRight:(int) angle;



@end
