//
//  AJStateController.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 19.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJStateController : NSObject

@property (nonatomic, assign) NSMutableSet *observers;

- (void) addObserver:(id) observer forMessage: (NSString *) message;

@end
