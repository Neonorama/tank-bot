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
        self.currentCommandIndex = 0;
    }
    return self;
}

-(AJCommand *)getCurrentCommand {
    return [self.commands objectForKey:[NSString stringWithFormat:@"%d",self.currentCommandIndex]];
}

-(void)addCommand:(AJCommand *)command atIndex:(int)index {
    [self.commands setObject:command forKey:[NSString stringWithFormat:@"%d",index]];
}

-(void)removeCommand:(AJCommand *)command atIndex:(int)index {
    [self.commands removeObjectForKey:[NSString stringWithFormat:@"%d",index]];
}

@end
