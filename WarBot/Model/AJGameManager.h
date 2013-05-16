//
//  AJGameManager.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 13.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AJBot.h"

@class AJProgramField;
@class AJAvailableCommands;
@class AJTriggers;
@class AJRegisters;



@interface AJGameManager : NSObject {
    
}

@property (nonatomic, assign) int programCounter;

@property (nonatomic, retain) AJProgramField *programField;
@property (nonatomic, retain) AJAvailableCommands *availableCommands;
@property (nonatomic, retain) AJTriggers *triggers;
@property (nonatomic, retain) AJRegisters *registers;

@property (nonatomic, retain) AJBot *bot;

- (void) nextStep;
- (void) checkCurrentState;

@end
