//
//  AJProgramField.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJCommand.h"
#import <Foundation/Foundation.h>

@interface AJProgramField : NSObject

@property (nonatomic, assign) int currentCommandIndex;
@property (nonatomic, strong) NSMutableDictionary *commands;

+(id)defaultField;

-(AJCommand *)getCurrentCommand;
-(void) addCommand: (AJCommand *) command atIndex:(int)index;
-(void) removeCommand: (AJCommand *) command atIndex:(int)index;

@end
