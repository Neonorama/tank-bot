//
//  AJGameScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameScene.h"
#import "AJMenuNode.h"
#import "AJFinishLevelScene.h"
#import "AJMainMenuScene.h"

@implementation AJGameScene

+(AJGameScene *)sceneWithSize:(CGSize)size options:(NSDictionary *)options {
    return [[self alloc] initWithSize:size options:options];
}

-(id)initWithSize:(CGSize)size options: (NSDictionary *) options
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.4 blue:0.15 alpha:0.8];

        self.gameManager = [[AJGameManager alloc] init];
        
        self.gameView = [[AJGameView alloc] initWithSize:size name: options[@"levelName"]];
        self.gameView.gameManager =  self.gameManager;
        self.gameView.position = CGPointMake(DEFAULT_COLS * DEFAULT_CELL_SIZE, 0);

        self.controlView = [[AJControlVew alloc] initWithSize:size];
//        self.controlView.zPosition = 100;
        self.controlView.gameManager =  self.gameManager;
        [self.controlView showProg];
        [self.controlView showAvailable];
        [self.controlView showRegisters];

        [self addChild:self.gameView];
        [self addChild:self.controlView];
        
        [self.gameView addChild:self.gameManager.bot.chassis];
        self.gameManager.bot.chassis.position = self.gameView.startPoint;
        self.gameManager.bot.chassis.zPosition = 10;
        self.gameManager.bot.parent = self.gameView;
//        self.gameManager.bot.track.zPosition = 10;
        self.gameManager.bot.track1.targetNode = self.gameView;
        self.gameManager.bot.track2.targetNode = self.gameView;
    
//        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_TIME_INTERVAL target:self selector:@selector(nextStep:) userInfo:nil repeats:YES];
        
        self.backgroundColor = [SKColor blackColor];
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(320, 0, 1024-320, 768)];
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        self.physicsBody.categoryBitMask = worldCategory;
        self.physicsBody.contactTestBitMask = botCategory | bulletCategory;
        self.physicsBody.collisionBitMask = botCategory | bulletCategory;
        [self.gameManager.bot initPhysics];
        
        SKSpriteNode *buttonMenuSprite = [SKSpriteNode spriteNodeWithImageNamed:@"menu"];
        SKSpriteNode *buttonPlaySprite = [SKSpriteNode spriteNodeWithImageNamed:@"play.png"];
        SKSpriteNode *buttonResetSprite = [SKSpriteNode spriteNodeWithImageNamed:@"reset"];
        SKSpriteNode *buttonTrashSprite = [SKSpriteNode spriteNodeWithImageNamed:@"trash"];
        SKSpriteNode *buttonPauseSprite = [SKSpriteNode spriteNodeWithImageNamed:@"pause"];
        
        AJMenuNode *buttonPlay = [AJMenuNode menuLabelNodeWithName:@"PlayButton"
                                                     text:@"  "
                                                 position:CGPointMake(160, 50)
                                                     size:16
                                                    block:^(id sender){
                                                        [self resume];
                                                    }];
        [buttonPlay addBackSprite:buttonPlaySprite];
        [self addChild:buttonPlay];
        
        AJMenuNode *buttonReset = [AJMenuNode menuLabelNodeWithName:@"ResetButton"
                                                     text:@"  "
                                                 position:CGPointMake(96, 50)
                                                     size:16
                                                    block:^(id sender){
                                                        [self pause];
                                                        [self reset];
                                                    }];
        [buttonReset addBackSprite:buttonResetSprite];
        [self addChild:buttonReset];
        
        AJMenuNode *buttonMenu = [AJMenuNode menuLabelNodeWithName:@"MenuButton"
                                                              text:@"  "
                                                          position:CGPointMake(32, 50)
                                                              size:16
                                                             block:^(id sender){
                                                                 [self mainMenu];
                                                             }];
        [buttonMenu addBackSprite:buttonMenuSprite];
        [self addChild:buttonMenu];
        
        AJMenuNode *buttonPause = [AJMenuNode menuLabelNodeWithName:@"PauseButton"
                                                              text:@"  "
                                                          position:CGPointMake(224, 50)
                                                              size:16
                                                             block:^(id sender){
                                                                 [self pause];
                                                             }];
        [buttonPause addBackSprite:buttonPauseSprite];
        [self addChild:buttonPause];
        
        AJMenuNode *buttonTrash = [AJMenuNode menuLabelNodeWithName:@"TrashButton"
                                                              text:@"  "
                                                          position:CGPointMake(290, 50)
                                                              size:16
                                                             block:^(id sender){
                                                                 [self cleanProg];
                                                             }];
        [buttonTrash addBackSprite:buttonTrashSprite];
        [self addChild:buttonTrash];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInView:self.view];
    
    NSLog(@"Game scene touch %@", NSStringFromCGPoint(touchLocationOne));
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void) nextStep: (NSTimer*) timer {
    [self.controlView nextStep:timer.timeInterval];
    [self.gameView nextStep:timer.timeInterval];
}

-(void)pause {
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}

-(void)resume {
    [self.gameTimer invalidate];
    self.gameTimer = nil;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_TIME_INTERVAL*1.1f target:self selector:@selector(nextStep:) userInfo:nil repeats:YES];
}

-(void)next {
    [self.controlView nextStep:DEFAULT_TIME_INTERVAL];
    [self.gameView nextStep:DEFAULT_TIME_INTERVAL];
}

- (void) reset {
    [self.gameView reset];
    
    
    self.gameManager.bot.chassis.position = self.gameView.startPoint;
}

- (void) cleanProg {
    [self.controlView cleanProg];
}

- (void) finish
{
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:0.5];
    AJFinishLevelScene *newScene = [[AJFinishLevelScene alloc] initWithSize: CGSizeMake(1024,768)];
    //  Optionally, insert code to configure the new scene.
    [self.scene.view presentScene: newScene transition: reveal];
}

- (void) mainMenu
{
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:0.5];
    AJMainMenuScene *newScene = [[AJMainMenuScene alloc] initWithSize: CGSizeMake(1024,768)];
    [self.scene.view presentScene: newScene transition: reveal];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & botCategory) != 0 &&
        (secondBody.categoryBitMask & wallCategory) != 0)
    {
        NSLog(@"Wall contact!!!");
        [self pause];
        [self reset];
    }
    
    if ((firstBody.categoryBitMask & botCategory) != 0 &&
        (secondBody.categoryBitMask & worldCategory) != 0)
    {
        NSLog(@"Wall contact!!!");
        [self pause];
        [self reset];
    }
    
    if ((firstBody.categoryBitMask & botCategory) != 0 &&
        (secondBody.categoryBitMask & finishCategory) != 0)
    {
        NSLog(@"Finish contact!!!");
        [self pause];
        [self finish];
    }
    
    if ((firstBody.categoryBitMask & bulletCategory) != 0 &&
        (secondBody.categoryBitMask & goalCategory) != 0)
    {
        [self bullet:firstBody.node didCollideWithGoal:secondBody.node];
        
        [self explosionOnPosition:[self convertPoint:secondBody.node.position fromNode:self.gameView]];
    }
    
    if ((firstBody.categoryBitMask & wallCategory) != 0 &&
        (secondBody.categoryBitMask & bulletCategory) != 0)
    {
        [self bullet:secondBody.node didCollideWithWall:firstBody.node];
        
        [self wallExplosionOnPosition:[self convertPoint:secondBody.node.position fromNode:self.gameView]];
    }
}

- (void) explosionOnPosition: (CGPoint)position {
    NSString *sparkPath = [[NSBundle mainBundle] pathForResource:@"boom" ofType:@"sks"];
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:sparkPath];
    spark.position = position;
    [self addChild:spark];
    
    [self runAction:[SKAction waitForDuration:0.2] completion:^{
        NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"smoke" ofType:@"sks"];
        SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
        smoke.position = position;
        [self addChild:smoke];
        
        NSString *firePath = [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
        SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
        fire.position = position;
        [self addChild:fire];
    }];
}

- (void) wallExplosionOnPosition: (CGPoint)position {
    NSString *sparkPath = [[NSBundle mainBundle] pathForResource:@"boom" ofType:@"sks"];
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:sparkPath];
    spark.position = position;
    [self addChild:spark];
    
//    [self runAction:[SKAction waitForDuration:0.2] completion:^{
//        NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"smoke" ofType:@"sks"];
//        SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
//        smoke.position = position;
//        [self addChild:smoke];
//        
//        NSString *firePath = [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
//        SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
//        fire.position = position;
//        [self addChild:fire];
//    }];
}

- (void)bullet:(SKSpriteNode *)bullet didCollideWithGoal:(SKSpriteNode *)goal {
    NSLog(@"Hit");
    [bullet removeFromParent];
    [goal removeFromParent];
}

- (void)bullet:(SKSpriteNode *)bullet didCollideWithWall:(SKSpriteNode *)goal {
    NSLog(@"Hit");
    [bullet removeFromParent];
}

- (void) clean {
    [self pause];
    [self.gameView clean];
    [self.controlView clean];
    [self.gameManager reset];
    [self removeAllActions];
    [self removeAllChildren];
}

-(void)willMoveFromView:(SKView *)view {
    [self clean];
}

@end
