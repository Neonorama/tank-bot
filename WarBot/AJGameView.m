//
//  AJGameView.m
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameView.h"

@implementation AJGameView

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
                
        SKTextureAtlas *texture = [SKTextureAtlas atlasNamed:@"bot"];
        
        SKSpriteNode *base = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_base.png"]];
        SKSpriteNode *canon = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_canon_1.png"]];
        base.zRotation = M_PI / 2;
        canon.zRotation = M_PI / 2;
        
        self.botBaseSprite = [[SKSpriteNode alloc] init];
        [self.botBaseSprite addChild:base];
        self.botCanonSprite= [[SKSpriteNode alloc] init];
        [self.botCanonSprite addChild:canon];
        
        self.botBaseSprite.anchorPoint = CGPointMake(0.5, 0.5);

        canon.anchorPoint = CGPointMake(0.5, 0.8);
        canon.position = CGPointMake(self.botBaseSprite.size.width * 7 / 10, self.botBaseSprite.size.height / 2);
        
        [self.botBaseSprite addChild:self.botCanonSprite];
        [self addChild:self.botBaseSprite];
        self.botBaseSprite.position = CGPointMake(round(size.width * 2 / 3), round(size.height / 2));
	}
	return self;
}

-(void)nextStep:(NSTimeInterval)delta{
    [self.gameManager nextStep];
    SKAction *botMove = [SKAction moveTo: CGPointMake(self.gameManager.bot.position.x, self.gameManager.bot.position.y)  duration:delta];
    float rotateRad = (self.gameManager.bot.chassis.orientation * M_PI / 180) ;
    SKAction *botRotate = [SKAction rotateToAngle:rotateRad duration:delta];
    SKAction *canonRotate = [SKAction rotateToAngle:(self.gameManager.bot.turret.localOrientation * M_PI / 180) duration:delta];

    [self.botBaseSprite runAction:[SKAction group:@[botMove, botRotate]]];
    [self.botCanonSprite runAction:canonRotate];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInView:self.view];
    
    NSLog(@"Game view touch %@", NSStringFromCGPoint(touchLocationOne));
}

@end
