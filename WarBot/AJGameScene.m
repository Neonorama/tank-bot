//
//  AJGameScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameScene.h"

@implementation AJGameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AJGameScene *layer = [AJGameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        AJGameManager *gameManager = [[AJGameManager alloc] init];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bot.plist" textureFilename:@"bot.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"arrows.plist" textureFilename:@"arrows.png"];


        self.gameView = [[AJGameView alloc] init];
        self.gameView.gameManager = gameManager;
        
        self.controlView = [[AJControlVew alloc] init];
        self.controlView.gameManager = gameManager;

        [self addChild:self.gameView];
        [self addChild:self.controlView];
    }
    return self;
}

@end
