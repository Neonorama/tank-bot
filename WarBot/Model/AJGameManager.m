//
//  AJGameManager.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 13.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameManager.h"
#import "AJStateController.h"

@implementation AJGameManager

-(void)nextStep {
    
    NSNumber *num = [NSNumber numberWithInt:20];
    [self.bot performSelector:NSSelectorFromString(@"moveBackward:") withObject:num];
}

-(void)checkCurrentState {
    ;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bot = [AJBot defaultBot];
        self.programField = [AJProgramField defaultField];
        
        /*
        [self.bot moveForward:20];
        [self.bot turnLeft:90];
        [self.bot turnTurret:45];
        [self.bot turnTurretLeft:90];
        [self.bot turnRight:45];
        [self.bot moveBackward:50];
        [self.bot turnLeft:45];
        [self.bot fire];
        [self.bot moveForward:50];
        [self.bot turnRight:90];
        [self.bot moveForward:50];
        [self.bot turnRight:90];
         */
    }
    return self;
}

@end
