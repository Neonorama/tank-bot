//
//  AJRegisters.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 12.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kRegistersA = 0,    // return register
    kRegistersB,        // 
    kRegistersC,
    kRegistersD,
    kRegistersE,
    kRegistersF,
    kRegistersG,
    kRegistersH
    
} kRegisters;

@interface AJRegisters : NSObject

@property (nonatomic, strong) NSMutableArray *registers;
@property (nonatomic, assign) id delegate;


+(id)defaultRegisters;

-(void) saveCurrentCommandIndex:(int) currentIndex;
-(int) loadCurrentCommandIndex;

@end
