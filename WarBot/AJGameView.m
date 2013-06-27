//
//  AJGameView.m
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameView.h"

@implementation AJGameView

-(id) init
{
	if( (self=[super init]) ) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.position = ccp(winSize.width / 2, winSize.width / 2);
                
        CCSprite *base = [CCSprite spriteWithSpriteFrameName:@"bot_base.png"];
        CCSprite *canon = [CCSprite spriteWithSpriteFrameName:@"bot_canon_1.png"];
        base.rotation = -90;
        canon.rotation = -90;
        
        self.botBaseSprite = [[CCSprite alloc] init];
        [self.botBaseSprite addChild:base];
        self.botCanonSprite= [[CCSprite alloc] init];
        [self.botCanonSprite addChild:canon];
        
        self.botBaseSprite.anchorPoint = ccp(0.5, 0.5);

        canon.anchorPoint = ccp(0.5, 0.8);
        canon.position = ccp(self.botBaseSprite.contentSize.width * 7 / 10, self.botBaseSprite.contentSize.height / 2);
        
        [self addChild:self.botBaseSprite];
        [self.botBaseSprite addChild:self.botCanonSprite];

		self.isTouchEnabled = YES;
        [self schedule:@selector(update:) interval:DEFAULT_TIME_INTERVAL];

	}
	return self;
}

-(void)update:(ccTime)dt{
    [self.gameManager nextStep];
    id botMove = [CCMoveTo actionWithDuration:DEFAULT_TIME_INTERVAL position:self.gameManager.bot.position];
    id botRotate = [CCRotateTo actionWithDuration:DEFAULT_TIME_INTERVAL angle:self.gameManager.bot.chassis.orientation];
    id canonRotate = [CCRotateTo actionWithDuration:DEFAULT_TIME_INTERVAL angle:self.gameManager.bot.turret.localOrientation];

    [self.botBaseSprite runAction:[CCSpawn actions:botMove, botRotate, nil]];
    [self.botCanonSprite runAction:canonRotate];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* allTouches = [[event allTouches] allObjects];
    
    if (!isMoving) {
        for (UITouch *touch in allTouches) {
            CGPoint position = [touch locationInView:[touch view]];
            position = [[CCDirector sharedDirector] convertToGL:position];
        }
    }
    isMoving = NO;
}



-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{    

}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoving = YES;

    NSArray* allTouches = [[event allTouches] allObjects];

    UITouch* touch = [allTouches objectAtIndex:0];

    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint prevLocation = [touch previousLocationInView: [touch view]];

    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];

    CGPoint diff = ccpSub(touchLocation,prevLocation);
    [self setPosition: ccpAdd(self.position, diff)];
}

- (void) dealloc
{
}


@end
