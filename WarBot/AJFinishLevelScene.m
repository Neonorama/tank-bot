//
//  AJFinishLevelScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.11.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJFinishLevelScene.h"
#import "AJMainMenuScene.h"
#import "AJMenuNode.h"

@implementation AJFinishLevelScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        //        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.4 blue:0.15 alpha:0.8];
        
    }
    return self;
}

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void) createSceneContents {
    self.backgroundColor = [SKColor purpleColor];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"BackToMenu"
                                                 text:@"Main menu"
                                             position:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
                                                 size:48
                                                block:^(id sender){
                                                    [self backToMainMenu];
                                                }]];
}

- (void) clean {
    [self removeAllActions];
    [self removeAllChildren];
}

-(void)willMoveFromView:(SKView *)view {
    [self clean];
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSArray* allTouches = [[event allTouches] allObjects];
//    
//    UITouch* touchOne = [allTouches objectAtIndex:0];
//    
//    CGPoint touchLocationOne = [touchOne locationInNode:self];
}

#pragma mark - Menu

- (void) backToMainMenu
{
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:0.5];
    AJMainMenuScene *newScene = [[AJMainMenuScene alloc] initWithSize: CGSizeMake(1024,768)];
    //  Optionally, insert code to configure the new scene.
    [self.scene.view presentScene: newScene transition: reveal];
}

@end
