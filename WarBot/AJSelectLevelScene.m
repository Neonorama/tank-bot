//
//  AJSelectLevelScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.11.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJSelectLevelScene.h"
#import "AJGameScene.h"
#import "AJMenuNode.h"

@interface AJSelectLevelScene ()

@property (nonatomic, strong) __block AJGameScene *selectedScene;

@end

@implementation AJSelectLevelScene

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
    
    NSMutableDictionary *level1Options = [[NSMutableDictionary alloc] init];
    
    [level1Options setObject:@"level1" forKey:@"levelName"];
    
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level1"
                                                 text:@"Level 1"
                                             position:CGPointMake(self.frame.size.width / 4, self.frame.size.height / 4 * 3)
                                                 size:36
                                                block:^{
                                                    self.selectedScene = [[AJGameScene alloc] initWithSize: CGSizeMake(1024,768) options:level1Options];
                                                    [self play];
                                                }]];
    
    
    NSMutableDictionary *level2Options = [[NSMutableDictionary alloc] init];
    [level2Options setObject:@"level2" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level2"
                                                 text:@"Level 2"
                                             position:CGPointMake(self.frame.size.width / 4, self.frame.size.height / 4 * 2)
                                                 size:36
                                                block:^{
                                                    self.selectedScene = [[AJGameScene alloc] initWithSize: CGSizeMake(1024,768) options:level2Options];
                                                    [self play];
                                                }]];
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

- (void) play
{
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    [self.scene.view presentScene: self.selectedScene transition: reveal];
}

@end
