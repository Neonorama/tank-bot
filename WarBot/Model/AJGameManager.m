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
        
        for (int i = 0; i < DEFAULT_PROGRAM_LENGTH; i++) {
            int t = arc4random() % 20;
            AJCommand *cmd;
            switch (t) {
                    // Bot command
                case 0:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"moveForward:" param:[NSNumber numberWithInt:20]];
                    break;
                case 1:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"moveBackward:" param:[NSNumber numberWithInt:20]];
                    break;
                case 2:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"turnLeft:" param:[NSNumber numberWithInt:90]];
                    break;
                case 3:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"turnRight:" param:[NSNumber numberWithInt:90]];
                    break;
                case 4:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"fire" param:[NSNumber numberWithInt:20]];
                    break;
                case 5:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"turnTurretLeft:" param:[NSNumber numberWithInt:90]];
                    break;
                case 6:
                    cmd = [AJCommand commandWithType:kCommandTypeBot command:@"turnTurretRight:" param:[NSNumber numberWithInt:90]];
                    break;

                case 8:
                    cmd = [AJCommand commandWithType:kCommandTypeProg command:@"jump:" param:[NSNumber numberWithInt:50]];
                    break;
                case 9:
                    cmd = [AJCommand commandWithType:kCommandTypeProg command:@"ret" param:[NSNumber numberWithInt:0]];
                    break;

                default:
                    cmd = [AJCommand commandWithType:kCommandTypeDefault command:@"" param:[NSNumber numberWithInt:0]];
                    break;
            }
            [self.programField addCommand:cmd atIndex:i];
        }
    }
    return self;
}

#pragma mark - AJProgramFieldProtocol

-(void) saveCurrentCommandIndex:(int) currentIndex {
    [self.registers saveCurrentCommandIndex:currentIndex];
}

-(int) loadCurrentCommandIndex {
    return [self.registers loadCurrentCommandIndex];
}


@end
