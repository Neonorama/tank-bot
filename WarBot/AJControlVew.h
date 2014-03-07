//
//  AJControlVew.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

#import "AJGameManager.h"

@interface AJControlVew : SKScene

@property AJGameManager *gameManager;
@property NSMutableArray *available;
@property NSMutableArray *program;
@property NSMutableArray *registers;
@property AJCommand *intermediateCommand;
@property SKSpriteNode *intermediateSprite;

- (void) showProg;
- (void) showAvailable;
- (void) showRegisters;
- (SKSpriteNode *) getCommandSprite: (AJCommand *) command;

- (void) nextStep:(NSTimeInterval)delta;

- (void) clean;
- (void) cleanProg;

@end
