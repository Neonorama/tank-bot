//
//  AJGameView.h
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AJGameManager.h"

@interface AJGameView : SKScene {
    BOOL isMoving;
}

@property AJGameManager *gameManager;
@property SKSpriteNode *botBaseSprite;
@property SKSpriteNode *botCanonSprite;

-(void)nextStep:(NSTimeInterval)delta;
-(void)generateLevel: (NSString *)levelName;
@end
