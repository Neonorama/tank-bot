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
    self.chassis.physicsBody.collisionBitMask = botCategory | wallCategory;
    self.chassis.physicsBody.contactTestBitMask = botCategory | wallCategory;
}

#pragma mark - Implementation chassis methods

- (void) moveForward:(NSNumber *) distance {
    int distance_ = [distance intValue];
    CGPoint t = self.chassis.position;
    t.x += round(distance_ * cosf(self.chassis.zRotation));
    t.y += round(distance_ * sinf(self.chassis.zRotation));
    
    SKAction *move = [SKAction moveTo:t duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:move];
    
    NSLog(@"Move forward by %d", distance_);
}

- (void) moveBackward:(NSNumber *) distance {
    int distance_ = [distance intValue];
    CGPoint t = self.chassis.position;
    t.x -= round(distance_ * cosf(self.chassis.zRotation));
    t.y -= round(distance_ * sinf(self.chassis.zRotation));
    
    SKAction *move = [SKAction moveTo:t duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:move];
    
    NSLog(@"Move backward by %d", distance_);
}

- (void) turn:(NSNumber *) angle {
    int angle_ = [angle intValue] ;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:rotate];
    
    NSLog(@"Turn by %d", angle_);
}

- (void) turnLeft:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:rotate];
    
    NSLog(@"Turn left by %d", [angle intValue]);
}

- (void) turnRight:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:-angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.chassis runAction:rotate];
    
    NSLog(@"Turn right by %d", [angle intValue]);
}

#pragma mark - Implementation turret methods

- (void) fire {
    NSLog(@"Fire");
}

- (void) turnTurret:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    
    [self.turret runAction:rotate];
    
    NSLog(@"Turn turret by %d", [angle intValue]);
}

- (void) turnTurretLeft:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.turret runAction:rotate];
    
    NSLog(@"Turn turret left by %d", [angle intValue]);
}

- (void) turnTurretRight:(NSNumber *) angle {
    float angle_ = [angle floatValue] * M_PI / 180.0;
    SKAction *rotate = [SKAction rotateByAngle:-angle_ duration:DEFAULT_TIME_INTERVAL];
    [self.turret runAction:rotate];
    
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
