//
//  AJCommand.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 30.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJCommand.h"
#import "AJConstants.h"

@implementation AJCommand

+(AJCommand *)commandWithType:(kCommandType)type command:(NSString *)command param:(NSNumber *)param {
    return [[self alloc] initCommandWithType:type command:command param:param];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.type = kCommandTypeDefault;
        self.command = kCommandDefault;
        self.param = [NSNumber numberWithInt:0];
    }
    return self;
}

-(id)initCommandWithType:(kCommandType)type command:(NSString *)command param:(NSNumber *)param {
    self = [super init];
    if (self) {
        self.type = type;
        self.command = command;
        self.param = param;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Command: type - %d, name - %@, param - %@", self.type, self.command, self.param];
}

-(id)copy {
    AJCommand *command = [AJCommand commandWithType:self.type command:self.command param:self.param];
    return command;
}

@end
