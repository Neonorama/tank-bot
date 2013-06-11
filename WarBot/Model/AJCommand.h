//
//  AJCommand.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 30.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface AJCommand : NSObject

@property (nonatomic, assign) kCommandType type;
@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSNumber *param;

+(AJCommand *)commandWithType:(kCommandType)type command:(NSString  *)command param: (NSNumber *)param;


@end
