//
//  AJFinishLevelScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.11.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJFinishLevelScene.h"
#import "AJMainMenuScene.h"

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
    self.backgroundColor = [SKColor greenColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self mainMenuNode]];
}

- (SKLabelNode *)mainMenuNode
{
    SKLabelNode *playNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    playNode.text = @"Main menu";
    playNode.fontSize = 42;
    playNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    playNode.name = @"PlayButton";
    return playNode;
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self];
}

#pragma mark - Menu

- (void) play
{
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    AJMainMenuScene *newScene = [[AJMainMenuScene alloc] initWithSize: CGSizeMake(1024,768)];
    //  Optionally, insert code to configure the new scene.
    [self.scene.view presentScene: newScene transition: reveal];
}

@end
