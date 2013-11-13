//
//  AJGameView.h
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AJGameManager.h"

@interface AJGameView : SKNode <SKPhysicsContactDelegate> {
    BOOL isMoving;
}

@property AJGameManager *gameManager;
@property SKSpriteNode *botBaseSprite;
@property SKSpriteNode *botCanonSprite;
@property CGPoint startPoint;
@property CGRect finishArea;
@property CGSize size;

-(void)nextStep:(NSTimeInterval)delta;
-(void)prevStep:(NSTimeInterval)delta;

-(void)generateLevel: (NSString *)levelName;
-(id)initWithSize:(CGSize)size;
@end
