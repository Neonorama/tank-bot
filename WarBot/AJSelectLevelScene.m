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
#import "AJMainMenuScene.h"

@interface AJSelectLevelScene ()

@property (nonatomic) __block NSDictionary *selectedSceneOptions;

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
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    NSMutableDictionary *level1Options = [NSMutableDictionary dictionary];
    
    [level1Options setObject:@"level1" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level1"
                                                 text:@"Level 1"
                                             position:CGPointMake(self.frame.size.width / 4, self.frame.size.height / 4 * 3)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level1Options];
                                                    [self play];
                                                }]];
    
    
    NSMutableDictionary *level2Options = [NSMutableDictionary dictionary];
    [level2Options setObject:@"level2" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level2"
                                                 text:@"Level 2"
                                             position:CGPointMake(self.frame.size.width / 4, self.frame.size.height / 4 * 2)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level2Options];
                                                    [self play];
                                                }]];
    
    NSMutableDictionary *level3Options = [NSMutableDictionary dictionary];
    [level3Options setObject:@"level3" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level3"
                                                 text:@"Level 3"
                                             position:CGPointMake(self.frame.size.width / 4, self.frame.size.height / 4 * 1)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level3Options];
                                                    [self play];
                                                }]];
    
    NSMutableDictionary *level4Options = [NSMutableDictionary dictionary];
    [level4Options setObject:@"level4" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level4"
                                                 text:@"Level 4"
                                             position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 3)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level4Options];
                                                    [self play];
                                                }]];
    
    NSMutableDictionary *level5Options = [NSMutableDictionary dictionary];
    [level5Options setObject:@"level5" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level5"
                                                 text:@"Level 5"
                                             position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 2)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level5Options];
                                                    [self play];
                                                }]];
    
    NSMutableDictionary *level6Options = [NSMutableDictionary dictionary];
    [level6Options setObject:@"level6" forKey:@"levelName"];
    [self addChild: [AJMenuNode menuLabelNodeWithName:@"Level6"
                                                 text:@"Level 6"
                                             position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 1)
                                                 size:36
                                                block:^(id sender){
                                                    _selectedSceneOptions = [NSDictionary dictionaryWithDictionary:level6Options];
                                                    [self play];
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

- (void) play
{
//    [self clean];
    SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:0.6];
    AJGameScene *newScene = [AJGameScene sceneWithSize: CGSizeMake(1024,768) options:_selectedSceneOptions];
    
    [self.scene.view presentScene: newScene transition: reveal];
}

- (void) mainMenu
{
    [self clean];
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:0.5];
    AJMainMenuScene *newScene = [[AJMainMenuScene alloc] initWithSize: CGSizeMake(1024,768)];
    [self.scene.view presentScene: newScene transition: reveal];
}

@end
