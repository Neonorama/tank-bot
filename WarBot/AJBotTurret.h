//
//  AJBotTurret.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 15.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface AJBotTurret : NSObject

@property (nonatomic, assign) AJTurretType turretType;
@property (nonatomic, assign) int localOrientation; // -179 - 180
@property (nonatomic, assign) int absOrientation;   //    0 - 359
@property (nonatomic, assign) int energy;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int charges;

@property (nonatomic, assign) id stateController;

+ (id) defaultBotTurret;

- (void) fire;
- (void) turnTurret:(int) angle;
- (void) turnTurretLeft:(int) angle;
- (void) turnTurretRight:(int) angle;

- (void) changePosition: (CGPoint) newPosition;
- (void) changeOrientation: (int) newOrientation;

@end
