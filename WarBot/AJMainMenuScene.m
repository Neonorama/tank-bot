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
    
    [self placeInstructions];
    
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

- (void) placeInstructions {
    SKTextureAtlas *controls = [SKTextureAtlas atlasNamed:@"controls"];
    
    SKLabelNode *instr = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    instr.text = NSLocalizedString(@"Instructions", nil);
    instr.fontSize = 24;
    instr.fontColor = [SKColor blackColor];
    instr.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    instr.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    instr.position = CGPointMake(68, self.size.height - 50);
    [self addChild:instr];
    
    SKSpriteNode *s1 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_base_backward.png"]];
    s1.position = CGPointMake(100, self.size.height - 100);
    SKLabelNode *l1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l1.text = NSLocalizedString(@"- Move tank backward", nil);
    l1.fontSize = 16;
    l1.fontColor = [SKColor blackColor];
    l1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l1.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l1.position = CGPointMake(s1.position.x + 40, s1.position.y);
    [self addChild:l1];
    [self addChild:s1];
    
    SKSpriteNode *s2 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_base_forward.png"]];
    s2.position = CGPointMake(100, self.size.height - 150);
    SKLabelNode *l2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l2.text = NSLocalizedString(@"- Move tank forward", nil);
    l2.fontSize = 16;
    l2.fontColor = [SKColor blackColor];
    l2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l2.position = CGPointMake(s2.position.x + 40, s2.position.y);
    [self addChild:l2];
    [self addChild:s2];
    
    SKSpriteNode *s3 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_base_turn_left.png"]];
    s3.position = CGPointMake(100, self.size.height - 200);
    SKLabelNode *l3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l3.text = NSLocalizedString(@"- Turn tank left", nil);
    l3.fontSize = 16;
    l3.fontColor = [SKColor blackColor];
    l3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l3.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l3.position = CGPointMake(s3.position.x + 40, s3.position.y);
    [self addChild:l3];
    [self addChild:s3];
    
    SKSpriteNode *s4 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_base_turn_right.png"]];
    s4.position = CGPointMake(100, self.size.height - 250);
    SKLabelNode *l4 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l4.text = NSLocalizedString(@"- Turn tank right", nil);
    l4.fontSize = 16;
    l4.fontColor = [SKColor blackColor];
    l4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l4.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l4.position = CGPointMake(s4.position.x + 40, s4.position.y);
    [self addChild:l4];
    [self addChild:s4];
    
    SKSpriteNode *s5 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_tower_turn_left.png"]];
    s5.position = CGPointMake(100, self.size.height - 300);
    SKLabelNode *l5 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l5.text = NSLocalizedString(@"- Turn turret left", nil);
    l5.fontSize = 16;
    l5.fontColor = [SKColor blackColor];
    l5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l5.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l5.position = CGPointMake(s5.position.x + 40, s5.position.y);
    [self addChild:l5];
    [self addChild:s5];
    
    SKSpriteNode *s6 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"control_button_tower_turn_right.png"]];
    s6.position = CGPointMake(100, self.size.height - 350);
    SKLabelNode *l6 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l6.text = NSLocalizedString(@"- Turn turret right", nil);
    l6.fontSize = 16;
    l6.fontColor = [SKColor blackColor];
    l6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l6.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l6.position = CGPointMake(s6.position.x + 40, s6.position.y);
    [self addChild:l6];
    [self addChild:s6];
    
    SKSpriteNode *s7 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"fire.png"]];
    s7.position = CGPointMake(100, self.size.height - 400);
    SKLabelNode *l7 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l7.text = NSLocalizedString(@"- Fire on target", nil);
    l7.fontSize = 16;
    l7.fontColor = [SKColor blackColor];
    l7.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l7.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l7.position = CGPointMake(s7.position.x + 40, s7.position.y);
    [self addChild:l7];
    [self addChild:s7];

    SKSpriteNode *s8 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"func.png"]];
    s8.position = CGPointMake(100, self.size.height - 450);
    
    SKLabelNode *l81 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l81.text = NSLocalizedString(@"- Function. Drag the cell of the", nil);
    l81.fontSize = 16;
    l81.fontColor = [SKColor blackColor];
    l81.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l81.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l81.position = CGPointMake(s8.position.x + 40, s8.position.y);
    
    SKLabelNode *l82 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l82.text = NSLocalizedString(@"program field on functional cell", nil);
    l82.fontSize = 16;
    l82.fontColor = [SKColor blackColor];
    l82.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l82.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l82.position = CGPointMake(s8.position.x + 40, s8.position.y - 25);
    
    SKLabelNode *l83 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l83.text = NSLocalizedString(@"from available to set the function.", nil);
    l83.fontSize = 16;
    l83.fontColor = [SKColor blackColor];
    l83.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l83.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l83.position = CGPointMake(s8.position.x + 40, s8.position.y - 50);
    
    
    
    [self addChild:l81];
    [self addChild:l82];
    [self addChild:l83];
    [self addChild:s8];

    SKSpriteNode *s9 = [SKSpriteNode spriteNodeWithTexture:[controls textureNamed:@"ret.png"]];
    s9.position = CGPointMake(100, self.size.height - 550);
    SKLabelNode *l9 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    l9.text = NSLocalizedString(@"- Return from function", nil);
    l9.fontSize = 16;
    l9.fontColor = [SKColor blackColor];
    l9.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    l9.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    l9.position = CGPointMake(s9.position.x + 40, s9.position.y);
    [self addChild:l9];
    [self addChild:s9];

    
}


@end
