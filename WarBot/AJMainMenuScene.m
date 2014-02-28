//
//  AJMainMenuScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 28.11.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJMainMenuScene.h"
#import "AJSelectLevelScene.h"
#import "AJMenuNode.h"
#import "AJGameScene.h"

#define PlayTagButton 101

@implementation AJMainMenuScene



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
    
    [self runAction:[SKAction waitForDuration:0.01] completion:^{
        NSString *sparkPath = [[NSBundle mainBundle] pathForResource:@"sparks" ofType:@"sks"];
        SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:sparkPath];
        spark.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [self addChild:spark];
    }];
}

- (void) createSceneContents {
    self.backgroundColor = [SKColor blueColor];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    SKSpriteNode *buttonBackground = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
    
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    AJMenuNode *playButton = [AJMenuNode menuLabelNodeWithName:@"PlayButton"
                                              text:NSLocalizedString(@"Tutorials", nil)
                                             position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 3)
                                                 size:48
                                                block:^(id sender){
                                                    [self play];
                                                }];
    [playButton addBackSprite:buttonBackground];
    
    AJMenuNode *campaignButton = [AJMenuNode menuLabelNodeWithName:@"Campaign"
                                                          text:NSLocalizedString(@"Campaign", nil)
                                                      position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 2)
                                                          size:48
                                                         block:^(id sender){
                                                             
                                                         }];
    
    [campaignButton addBackSprite:buttonBackground];
    
    AJMenuNode *randButton = [AJMenuNode menuLabelNodeWithName:@"Randomize"
                                                 text:NSLocalizedString(@"Random", nil)
                                             position:CGPointMake(self.frame.size.width / 4 * 3, self.frame.size.height / 4 * 1)
                                                 size:48
                                                block:^(id sender){
                                                    [self playRandom];
                                                }];
    [randButton addBackSprite:buttonBackground];
    
    [self addChild:playButton];
    [self addChild:randButton];
    [self addChild:campaignButton];
    
    SKLabelNode *coming = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    coming.text = NSLocalizedString(@"Coming soon", nil);
    coming.fontColor = [UIColor redColor];
    coming.position = CGPointMake(30, 5);
    coming.zRotation = M_PI / 10;
//    coming.blendMode = SKBlendModeMultiply;
    
    [campaignButton.label addChild:coming];
    
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
    [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:0.5];
        AJSelectLevelScene *newScene = [[AJSelectLevelScene alloc] initWithSize: CGSizeMake(1024,768)];
        [self.scene.view presentScene: newScene transition: reveal];
    }], [SKAction runBlock:^{
        [self clean];
    }]]]];
}

- (void) playRandom
{
    SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:0.6];
    AJGameScene *newScene = [AJGameScene sceneWithSize: CGSizeMake(1024,768) options:@{@"levelName": @"random"}];
    
    [self runAction:[SKAction waitForDuration:0.5] completion:^{
        [self.scene.view presentScene: newScene transition: reveal];
    }];
}

-(void)dealloc{
    
}


@end
