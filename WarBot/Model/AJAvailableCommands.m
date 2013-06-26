//
//  AJAvailableCommands.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 18.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJAvailableCommands.h"
#import "Utils.h"
#import "AJCommand.h"
#import "AJConstants.h"

@implementation AJAvailableCommands

+(id)defaultAvailableCommands {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.availableCommands = [NSMutableArray arrayWithCapacity:DEFAULT_AVAILIABLE_LENGTH];
        
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandMoveForward param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandMoveBackward param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandTurnLeft param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandTurnRight param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandFire param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandTurnTurretLeft param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:kCommandTurnTurretRight param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeProg command:kCommandJump param:[NSNumber numberWithInt:50]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeProg command:kCommandRet param:[NSNumber numberWithInt:0]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeDefault command:kCommandDefault param:[NSNumber numberWithInt:0]]];
    }
    return self;
}

@end
