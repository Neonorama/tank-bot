//
//  AJAvailableCommands.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 18.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJAvailableCommands : NSObject

@property (nonatomic) NSMutableArray *availableCommands;

+(id) defaultAvailableCommands;

@end
