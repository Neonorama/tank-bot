//
//  AJControlVew.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "CCLayer.h"
#import "AJGameManager.h"
#import "cocos2d.h"

@interface AJControlVew : CCLayer

@property AJGameManager *gameManager;

- (void) showProg;
- (CCSprite *) getCommandSprite: (AJCommand *) command;

@end
