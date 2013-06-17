//
//  AJRegisters.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 12.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface AJRegisters : NSObject

@property (nonatomic, strong) NSMutableArray *registers;
@property (nonatomic, assign) id delegate;


+(id)defaultRegisters;

-(void) setCurrentCommandIndex:(int) currentIndex;
-(int) getCurrentCommandIndex;
-(void)setParam:(NSNumber *)param toRegister:(kRegisters)reg;
-(NSNumber *)getParamFromRegister:(kRegisters)reg;
-(void) jump:(NSNumber *) param;
-(void) ret;

@end
