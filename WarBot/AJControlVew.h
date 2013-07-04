//
//  AJControlVew.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

#import "AJGameManager.h"

@interface AJControlVew : SKView

@property AJGameManager *gameManager;
@property NSMutableArray *available;
@property NSMutableArray *program;
@property AJCommand *intermediateCommand;

- (void) showProg;
- (void) showAvailable;
- (SKSpriteNode *) getCommandSprite: (AJCommand *) command;

@end
