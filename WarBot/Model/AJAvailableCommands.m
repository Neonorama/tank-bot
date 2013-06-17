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

@implementation AJAvailableCommands

+(id)defaultAvailableCommands {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.availableCommands = [NSMutableArray arrayWithCapacity:DEFAULT_AVAILIABLE_LENGTH];
        
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"moveForward:" param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"moveBackward:" param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"turnLeft:" param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"turnRight:" param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"fire" param:[NSNumber numberWithInt:20]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"turnTurretLeft:" param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeBot command:@"turnTurretRight:" param:[NSNumber numberWithInt:90]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeProg command:@"jump:" param:[NSNumber numberWithInt:50]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeProg command:@"ret" param:[NSNumber numberWithInt:0]]];
        [self.availableCommands addObject:[AJCommand commandWithType:kCommandTypeDefault command:@"" param:[NSNumber numberWithInt:0]]];
    }
    return self;
}

@end
