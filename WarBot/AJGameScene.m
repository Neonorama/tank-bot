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

@implementation AJGameScene

-(id)initWithSize:(CGSize)size 
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.4 blue:0.15 alpha:0.8];

        self.gameManager = [[AJGameManager alloc] init];
        
        self.gameView = [[AJGameView alloc] initWithSize:size];
        self.gameView.gameManager =  self.gameManager;
        self.gameView.position = CGPointMake(DEFAULT_COLS * DEFAULT_CELL_SIZE, 0);

        self.controlView = [[AJControlVew alloc] initWithSize:size];

        self.controlView.gameManager =  self.gameManager;
        [self.controlView showProg];
        [self.controlView showAvailable];
        [self.controlView showRegisters];

        [self addChild:self.gameView];
        [self addChild:self.controlView];
        
        [self.gameView addChild:self.gameManager.bot.chassis];
        self.gameManager.bot.chassis.position = self.gameView.startPoint;
        self.gameManager.bot.chassis.zPosition = 10;
    
//        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:DEFAULT_TIME_INTERVAL target:self selector:@selector(nextStep:) userInfo:nil repeats:YES];
        
        self.backgroundColor = [SKColor blackColor];
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        [self.gameManager.bot initPhysics];
        
        [self addChild: [AJMenuNode menuLabelNodeWithName:@"PlayButton"
                                                     text:@"Play!"
                                                 position:CGPointMake(size.width / 2, size.height - 100)
                                                    block:^{
                                                        [self resume];
                                                    }]];
        
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

- (void) reset {
    [self.gameView reset];
    
    
    self.gameManager.bot.chassis.position = self.gameView.startPoint;
}

- (void) finish
{
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.5];
    AJFinishLevelScene *newScene = [[AJFinishLevelScene alloc] initWithSize: CGSizeMake(1024,768)];
    //  Optionally, insert code to configure the new scene.
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
    
    if ((secondBody.categoryBitMask & wallCategory) != 0)
    {
        NSLog(@"Wall contact!!!");
        [self pause];
        [self reset];
    }
    
    if ((secondBody.categoryBitMask & finishCategory) != 0)
    {
        NSLog(@"Finish contact!!!");
        [self pause];
        [self finish];
    }
}

-(void)dealloc {
    
}

@end
