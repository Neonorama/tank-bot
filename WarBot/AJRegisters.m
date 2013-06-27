//
//  AJRegisters.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 12.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJRegisters.h"

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

-(void)setParam:(NSNumber *)param toRegister:(kRegisters)reg {
    self.registers[reg] = param;
}

-(NSNumber *)getParamFromRegister:(kRegisters)reg {
    return self.registers[reg];
}

-(void)move:(kRegisters) A :(kRegisters) B {
    self.registers[A] = self.registers[B];
}

-(void)setCurrentCommandIndex:(int)currentIndex {
    [self setParam:[NSNumber numberWithInt:currentIndex] toRegister:kRegistersB];
}

-(int)getCurrentCommandIndex {
    return [[self getParamFromRegister:kRegistersB] intValue];
}

-(void) jump:(NSNumber *) param {
    [self move:kRegistersA :kRegistersB];
    [self setParam:param toRegister:kRegistersB];
}

-(void) ret {
    [self move:kRegistersB :kRegistersA];
}

@end
