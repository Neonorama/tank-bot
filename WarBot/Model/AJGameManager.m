//
//  AJGameManager.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 13.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameManager.h"
#import "AJStateController.h"
#import "AJCommand.h"

@implementation AJGameManager

-(void)nextStep {
    NSLog(@"===============================================");
    [self checkCurrentState];
    AJCommand *currCmd = [self.programField getCurrentCommand];
    NSLog(@"%@", currCmd);
    switch (currCmd.type) {
        case kCommandTypeBot:
            [self.bot performSelector:NSSelectorFromString(currCmd.command) withObject:currCmd.param];
            break;
            
        case kCommandTypeProg:
            [self.programField performSelector:NSSelectorFromString(currCmd.command) withObject:currCmd.param];
            break;
            
        default:
            break;
    }
}

-(void)checkCurrentState {
    NSLog(@"%@", self.bot);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bot = [AJBot defaultBot];
        self.programField = [AJProgramField defaultField];
        [self.programField setDelegate:self];
        
        self.registers = [AJRegisters defaultRegisters];
        [self.registers setDelegate:self];
        
        self.availableCommands = [AJAvailableCommands defaultAvailableCommands];
        
        for (int i = 0; i < DEFAULT_PROGRAM_LENGTH; i++) {
            int t = arc4random() % [self.availableCommands.availableCommands count];
            AJCommand *cmd = [self.availableCommands.availableCommands objectAtIndex:t];
            
            [self.programField addCommand:cmd atIndex:i];
        }
    }
    return self;
}

#pragma mark - AJProgramFieldProtocol

-(void) setCurrentCommandIndex:(int) currentIndex {
    [self.registers setCurrentCommandIndex:currentIndex];
}

-(int) getCurrentCommandIndex {
    return [self.registers getCurrentCommandIndex];
}

-(void) jump:(NSNumber *) param {
    [self.registers jump:param];
}

-(void) ret {
    [self.registers ret];
}

@end
