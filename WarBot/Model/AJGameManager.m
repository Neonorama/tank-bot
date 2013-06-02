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
    [self checkCurrentState];
    AJCommand *currCmd = [self.programField getCurrentCommand];
    [self.bot performSelector:NSSelectorFromString(currCmd.command) withObject:currCmd.param];
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
        
        for (int i = 0; i <= 10; i++) {
            int t = arc4random() % 7;
            AJCommand *cmd;
            switch (t) {
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
                    
                default:
                    break;
            }
            [self.programField addCommand:cmd atIndex:i];
        }
    }
    return self;
}

@end
