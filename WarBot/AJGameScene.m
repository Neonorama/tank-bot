//
//  AJGameScene.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameScene.h"

static const uint32_t botCategory       = 0x1 << 0;
static const uint32_t wallCategory      = 0x1 << 1;
static const uint32_t bulletCategory    = 0x1 << 2;

@implementation AJGameScene

-(id)initWithSize:(CGSize)size 
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.4 blue:0.15 alpha:0.8];

        self.gameManager = [[AJGameManager alloc] init];
        
        self.gameView = [[AJGameView alloc] initWithSize:size];
        self.gameManager.bot.chassis.position = self.gameView.botBaseSprite.position;
        self.gameManager.bot.position = self.gameView.botBaseSprite.position;
        self.gameView.gameManager =  self.gameManager;
        self.gameView.position = CGPointMake(DEFAULT_COLS * DEFAULT_CELL_SIZE, 0);

        self.controlView = [[AJControlVew alloc] initWithSize:size];

        self.controlView.gameManager =  self.gameManager;
        [self.controlView showProg];
        [self.controlView showAvailable];
        [self.controlView showRegisters];

        [self addChild:self.gameView];
        [self addChild:self.controlView];
    
//        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_TIME_INTERVAL target:self selector:@selector(nextStep:) userInfo:nil repeats:YES];
        
        self.backgroundColor = [SKColor blackColor];
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        
//        SKTextureAtlas *texture = [SKTextureAtlas atlasNamed:@"bot"];
//        
//        SKSpriteNode *base = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_base.png"]];
//        base.zPosition = 200;
//        base.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:base.size];
//        base.physicsBody.categoryBitMask = botCategory;
//        base.physicsBody.collisionBitMask = botCategory | wallCategory;
//        base.physicsBody.contactTestBitMask = botCategory | wallCategory;
//        base.position = CGPointMake(300, 300);
//        base.zRotation = 20;
//        [self addChild:base];
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
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_TIME_INTERVAL target:self selector:@selector(nextStep:) userInfo:nil repeats:YES];
}

-(void)next {
    [self.controlView nextStep:DEFAULT_TIME_INTERVAL];
    [self.gameView nextStep:DEFAULT_TIME_INTERVAL];
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
    if ((firstBody.categoryBitMask & botCategory) != 0)
    {
        if (!self.gameManager.isPrevious) {
            NSLog(@"Contact!!!");
            [self.gameView prevStep:DEFAULT_TIME_INTERVAL];
            [self.gameManager jump:[self.gameManager.registers getParamFromRegister:kRegistersC]];
        }
    }
}
@end
