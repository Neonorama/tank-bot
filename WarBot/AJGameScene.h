//
//  AJGameScene.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

#import "AJGameView.h"
#import "AJControlVew.h"
#import "AJGameManager.h"

@interface AJGameScene : SKScene

@property AJGameView *gameView;
@property AJControlVew *controlView;

-(void) pause;
-(void) resume;

@end
