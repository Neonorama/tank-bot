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

@property (nonatomic) AJGameManager *gameManager;
@property (nonatomic) AJGameView *gameView;
@property (nonatomic) AJControlVew *controlView;
@property (nonatomic) NSTimer *gameTimer;

-(void) pause;
-(void) resume;
-(void) next;
-(void) clean;

+(AJGameScene *) sceneWithSize:(CGSize)size options: (NSDictionary *) options;
-(id)initWithSize:(CGSize)size options: (NSDictionary *) options;

@end
