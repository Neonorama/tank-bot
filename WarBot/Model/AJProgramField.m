//
//  AJProgramField.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJProgramField.h"
#import "AJConstants.h"

@implementation AJProgramField


+(id)defaultField{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.commands = [[NSMutableDictionary alloc] initWithCapacity:DEFAULT_PROGRAM_LENGTH];
        
        for (int i = 0; i < DEFAULT_PROGRAM_LENGTH; i++) {
            AJCommand *defaultCommand = [[AJCommand alloc] init];
            [self addCommand:defaultCommand atIndex:i];
        }
    }
    return self;
}

-(AJCommand *)getCurrentCommand {
    int index = [self.delegate getCurrentCommandIndex];
    AJCommand *command = [self.commands objectForKey:[NSString stringWithFormat:@"%d",index]];
    index++;
    if (index >= [self.commands count]) {
        index = 0;
    }
    [self.delegate setCurrentCommandIndex:index];
    return command;
}

-(void)addCommand:(AJCommand *)command atIndex:(int)index {
    [self removeCommandAtIndex:index];
    [self.commands setObject:command forKey:[NSString stringWithFormat:@"%d",index]];
}

-(void)removeCommandAtIndex:(int)index {
    [self.commands removeObjectForKey:[NSString stringWithFormat:@"%d",index]];
    [self.commands setObject:[AJCommand commandWithType:kCommandTypeDefault command:kCommandDefault param:@0] forKey:[NSString stringWithFormat:@"%d",index]];
}

-(void)jump:(NSNumber *)param{
    [self.delegate jump:param];
}

-(void)ret{
    [self.delegate ret];
}

-(void)replaceCommand:(AJCommand *)cmd1 to:(AJCommand *)cmd2 {
    NSArray *keys = [self.commands allKeysForObject:cmd1];
    [self addCommand:cmd2 atIndex:[keys[0] integerValue]];
}

@end
