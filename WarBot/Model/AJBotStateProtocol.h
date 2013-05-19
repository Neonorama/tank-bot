//
//  AJBotStateProtocol.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 19.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJBotStateProtocol <NSObject>

-(void)setNewPosition: (CGPoint) newPosition;
-(void)setNewOrientation: (int) newOrientation;

@end
