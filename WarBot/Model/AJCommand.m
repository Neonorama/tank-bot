//
//  AJCommand.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 30.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJCommand.h"

@implementation AJCommand

- (id)init
{
    self = [super init];
    if (self) {
        self.type = kCommandTypeDefault;
        self.command = @"";
        self.param = [NSNumber numberWithInt:0];
    }
    return self;
}

@end
