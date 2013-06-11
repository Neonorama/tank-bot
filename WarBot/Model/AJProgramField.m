//
//  AJProgramField.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJProgramField.h"

@implementation AJProgramField


+(id)defaultField{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.commands = [[NSMutableDictionary alloc] initWithCapacity:DEFAULT_PROGRAM_LENGTH];
        
        AJCommand *defaultCommand = [[AJCommand alloc] init];
        for (int i = 0; i < DEFAULT_PROGRAM_LENGTH; i++) {
            [self addCommand:defaultCommand atIndex:i];
        }
        self.currentCommandIndex = 0;
    }
    return self;
}

-(AJCommand *)getCurrentCommand {
    AJCommand *command = [self.commands objectForKey:[NSString stringWithFormat:@"%d",self.currentCommandIndex]];
    self.currentCommandIndex++;
    if (self.currentCommandIndex >= [self.commands count]) {
        self.currentCommandIndex = 0;
    }
    return command;
}

-(void)addCommand:(AJCommand *)command atIndex:(int)index {
    [self removeCommandAtIndex:index];
    [self.commands setObject:command forKey:[NSString stringWithFormat:@"%d",index]];
}

-(void)removeCommandAtIndex:(int)index {
    [self.commands removeObjectForKey:[NSString stringWithFormat:@"%d",index]];
}

-(void)mov:(NSNumber *)param{
    [self.delegate saveCurrentCommandIndex:self.currentCommandIndex];
    self.currentCommandIndex = [param intValue];
}

-(void)ret{
    self.currentCommandIndex = [self.delegate loadCurrentCommandIndex];
}

@end
