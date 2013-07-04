//
//  AJGameScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameScene.h"

@implementation AJGameScene

- (id)init
{
    self = [super init];
    if (self) {
        
        AJGameManager *gameManager = [[AJGameManager alloc] init];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

//        self.gameView = [[AJGameView alloc] init];
//        self.gameView.gameManager = gameManager;
//        
//        self.controlView = [[AJControlVew alloc] init];
//        
//        self.controlView.gameManager = gameManager;
//        [self.controlView showProg];
//        [self.controlView showAvailable];
//        
//        [self addChild:self.gameView];
//        [self addChild:self.controlView];
    }
    return self;
}

//-(void)update:(ccTime)delta {
//    [self.gameView update:delta];
//    [self.controlView update:delta];
//}

-(void)pause {
    ;
}

-(void)resume {
    ;
}
@end
