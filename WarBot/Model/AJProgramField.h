//
//  AJProgramField.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJCommand.h"
#import <Foundation/Foundation.h>

@protocol AJProgramFieldProtocol <NSObject>

-(void) setCurrentCommandIndex:(int) currentIndex;
-(int) getCurrentCommandIndex;
-(void) jump:(NSNumber *) param;
-(void) ret;

@end


@interface AJProgramField : NSObject

@property (nonatomic, strong) NSMutableDictionary *commands;
@property (nonatomic, assign) id <AJProgramFieldProtocol> delegate;

+(id)defaultField;

-(AJCommand *)getCurrentCommand;
-(void) addCommand: (AJCommand *) command atIndex:(int)index;
-(void) removeCommandAtIndex:(int)index;

-(void) jump:(NSNumber *) param;
-(void) ret;

@end

