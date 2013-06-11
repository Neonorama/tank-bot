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

-(void) saveCurrentCommandIndex:(int) currentIndex;
-(int) loadCurrentCommandIndex;

@end


@interface AJProgramField : NSObject

@property (nonatomic, assign) int currentCommandIndex;
@property (nonatomic, strong) NSMutableDictionary *commands;
@property (nonatomic, assign) id <AJProgramFieldProtocol> delegate;

+(id)defaultField;

-(AJCommand *)getCurrentCommand;
-(void) addCommand: (AJCommand *) command atIndex:(int)index;
-(void) removeCommandAtIndex:(int)index;

-(void) mov:(NSNumber *) param;
-(void) ret;

@end

