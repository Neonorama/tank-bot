//
//  AJRegisters.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 12.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJRegisters.h"
#import "Utils.h"

@implementation AJRegisters

+(id)defaultRegisters{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.registers = [[NSMutableArray alloc] initWithCapacity:DEFAULT_REGISTERS_LENGTH];
        for (int i = 0; i < DEFAULT_REGISTERS_LENGTH; i++) {
            [self.registers addObject:[NSNumber numberWithInt:0]];
        }
    }
    return self;
}

-(void)saveCurrentCommandIndex:(int)currentIndex {
    self.registers[kRegistersA] = [NSNumber numberWithInt:currentIndex];
}

-(int)loadCurrentCommandIndex {
    return [[self.registers objectAtIndex:kRegistersA] intValue];
}

@end
