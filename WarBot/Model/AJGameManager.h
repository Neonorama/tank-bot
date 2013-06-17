//
//  AJGameManager.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 13.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AJBot.h"
#import "AJProgramField.h"
#import "AJRegisters.h"
#import "AJAvailableCommands.h"

@class AJTriggers;
@class AJGameField;

@interface AJGameManager : NSObject <AJProgramFieldProtocol> {
    
}

@property (nonatomic, retain) AJProgramField *programField;
@property (nonatomic, retain) AJAvailableCommands *availableCommands;
@property (nonatomic, retain) AJTriggers *triggers;
@property (nonatomic, retain) AJRegisters *registers;
@property (nonatomic, retain) AJGameField *gameField;

@property (nonatomic, retain) AJBot *bot;   // done

- (void) nextStep;
- (void) checkCurrentState;

@end
