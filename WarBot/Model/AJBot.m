//
//  AJBot.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 14.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJBot.h"

@implementation AJBot

+ (id) defaultBot {
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {

        self.fuel       = DEFAULT_FUEL;
        
        SKTextureAtlas *texture = [SKTextureAtlas atlasNamed:@"bot"];
        
        SKSpriteNode *chassis_ = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_base.png"]];
        SKSpriteNode *turret_ = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_tower.png"]];
        chassis_.zRotation = 0;
        turret_.zRotation = 0;
        
        self.chassis = [SKSpriteNode spriteNodeWithColor:Nil size:chassis_.size];
        [self.chassis addChild:chassis_];
        
        self.turret = [SKSpriteNode spriteNodeWithColor:Nil size:turret_.size];
        [self.turret addChild:turret_];
        
        [self.chassis addChild:self.turret];
    }
    return self;
}

+ (AJBot *)botWithChassisName:(NSString *)chassisName andTurretName:(NSString *)turretName {
    return [[self alloc] initWithChassisName:chassisName andTurretName:turretName];
}

- (id)initWithChassisName:(NSString *)chassisName andTurretName:(NSString *)turretName {
    self = [super init];
    if (self) {
        self.fuel       = DEFAULT_FUEL;
        
        SKTextureAtlas *texture = [SKTextureAtlas atlasNamed:@"bot"];
        
        self.chassis = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_base.png"]];
        self.turret = [SKSpriteNode spriteNodeWithTexture:[texture textureNamed:@"bot_tower.png"]];
        
        [self.chassis addChild:self.turret];
    }
    return self;
}

- (void) initPhysics {
    self.chassis.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.chassis.size.height / 3];
    self.chassis.physicsBody.categoryBitMask = botCategory;
    self.chassis.physicsBody.collisionBitMask = 0;
    self.chassis.physicsBody.contactTestBitMask =  wallCategory | finishCategory;
}

#pragma mark - Implementation chassis methods

- (void) moveForward:(NSNumber *) distance {
    int distance_ = [distance intValue];
    CGPoint t = self.chassis.position;
    t.x += round(distance_ * cosf(self.chassis.zRotation));
    t.y += round(distance_ * sinf(self.chassis.zRotation));
    
    SKAction *move = [SKAction moveTo:t duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:move];
    [self.chassis runAction:[SKAction playSoundFileNamed:@"bot_engine.m4a" waitForCompletion:NO]];
    
    NSLog(@"Move forward by %d", distance_);
}

- (void) moveBackward:(NSNumber *) distance {
    int distance_ = [distance intValue];
    CGPoint t = self.chassis.position;
    t.x -= round(distance_ * cosf(self.chassis.zRotation));
    t.y -= round(distance_ * sinf(self.chassis.zRotation));
    
    SKAction *move = [SKAction moveTo:t duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:move];
    [self.chassis runAction:[SKAction playSoundFileNamed:@"bot_engine.m4a" waitForCompletion:NO]];
    
    NSLog(@"Move backward by %d", distance_);
}

- (void) turn:(NSNumber *) angle {
    int angle_ = [angle intValue] ;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:rotate];
    [self.chassis runAction:[SKAction playSoundFileNamed:@"bot_engine.m4a" waitForCompletion:NO]];
    
    NSLog(@"Turn by %d", angle_);
}

- (void) turnLeft:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    
    [self.chassis runAction:rotate];
    [self.chassis runAction:[SKAction playSoundFileNamed:@"bot_engine.m4a" waitForCompletion:NO]];
    
    NSLog(@"Turn left by %d", [angle intValue]);
}

- (void) turnRight:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:-angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:rotate];
    [self.chassis runAction:[SKAction playSoundFileNamed:@"bot_engine.m4a" waitForCompletion:NO]];
    
    NSLog(@"Turn right by %d", [angle intValue]);
}

#pragma mark - Implementation turret methods

- (void) fire {
    NSLog(@"Fire");
    
    SKSpriteNode * bullet = [SKSpriteNode spriteNodeWithImageNamed:@"bullet.png"];
    bullet.zRotation = self.turret.zRotation - M_PI_2;
    bullet.position = self.chassis.position;
//    bullet.position = [self.parent convertPoint:self.chassis.position fromNode:self.parent];
    bullet.zPosition = 15;
    [self.parent addChild:bullet];
    
    float distance = 1000.0f;
    CGVector direction = CGVectorMake(distance * cosf(self.turret.zRotation + self.chassis.zRotation), distance * sinf(self.turret.zRotation + self.chassis.zRotation));
    
    SKAction * actionMove = [SKAction moveBy:direction duration:5.0];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    bullet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
    bullet.physicsBody.categoryBitMask = bulletCategory;
    bullet.physicsBody.collisionBitMask = 0;
    bullet.physicsBody.contactTestBitMask = wallCategory | goalCategory;

    [bullet runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

- (void) turnTurret:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    
    [self.turret runAction:rotate];
    [self.turret runAction:[SKAction playSoundFileNamed:@"bot_turret.m4a" waitForCompletion:NO]];
    
    NSLog(@"Turn turret by %d", [angle intValue]);
}

- (void) turnTurretLeft:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.turret runAction:rotate];
    [self.turret runAction:[SKAction playSoundFileNamed:@"bot_turret.m4a" waitForCompletion:NO]];

    NSLog(@"Turn turret left by %d", [angle intValue]);
}

- (void) turnTurretRight:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:-angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.turret runAction:rotate];
    [self.turret runAction:[SKAction playSoundFileNamed:@"bot_turret.m4a" waitForCompletion:NO]];

    NSLog(@"Turn turret right by %d", [angle intValue]);
}

#pragma mark -

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Bot state:\tPosition: %@", NSStringFromCGPoint(self.chassis.position)];
}

#pragma mark - NSCopy protocol

-(id)copyWithZone:(NSZone *)zone {
    
    AJBot *newBot = [AJBot defaultBot];
    
    newBot.energy     = self.energy;
    newBot.fuel       = self.fuel;
    newBot.chassis.position   = self.chassis.position;
    newBot.turret.position = self.turret.position;

    return newBot;
}






@end
