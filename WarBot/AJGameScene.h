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

@interface AJGameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) AJGameManager *gameManager;
@property (nonatomic, strong) AJGameView *gameView;
@property (nonatomic, strong) AJControlVew *controlView;
@property (nonatomic, strong) NSTimer *gameTimer;

-(void) pause;
-(void) resume;
-(void) next;

@end
