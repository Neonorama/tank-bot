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

@property (nonatomic, retain) AJGameManager *gameManager;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGRect finishArea;
@property (nonatomic, assign) CGSize size;

-(void) nextStep:(NSTimeInterval)delta;
-(void) reset;

-(void)generateLevel: (NSString *)levelName;
-(id)initWithSize:(CGSize)size name: (NSString *) levelName;
@end
