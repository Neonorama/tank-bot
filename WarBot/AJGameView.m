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
        
        [self generateLevel:@"testLevel"];
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

-(void)generateLevel:(NSString *)levelName {
    NSError *error;
    NSString *levelFileName = [[NSBundle mainBundle] pathForResource:@"testLevel" ofType:@"json"];
    NSData *levelData = [NSData dataWithContentsOfFile:levelFileName];
    NSDictionary *levelDict = [NSJSONSerialization
                          JSONObjectWithData:levelData
                          options:kNilOptions
                          error:&error];
    
    NSArray *layers = [levelDict objectForKey:@"layers"];
    NSArray *tilesets = [levelDict objectForKey:@"tilesets"];
    
    NSDictionary *tileSet = (NSDictionary *)tilesets[0];
    
    NSString *tileSetFileName = [[NSBundle mainBundle] pathForResource:[[tileSet objectForKey:@"image"] stringByDeletingPathExtension] ofType:@"png"];
    SKTexture *tileTexture = [SKTexture textureWithImageNamed:tileSetFileName];
    
    int imageheight = [[tileSet objectForKey:@"imageheight"] integerValue];
    int imagewidth = [[tileSet objectForKey:@"imagewidth"] integerValue];
    int tileheight = [[tileSet objectForKey:@"tileheight"] integerValue];
    int tilewidth = [[tileSet objectForKey:@"tilewidth"] integerValue];
    
    int tileHeightCount = (imageheight / tileheight);
    int tileWidthCount = (imagewidth / tilewidth);
    int tileCount = tileHeightCount * tileWidthCount;

    NSMutableArray *tiles = [NSMutableArray arrayWithCapacity:tileCount];
    
    for (int i = 0; i < tileCount; i++) {
        float height = (float)tileheight / (float)imageheight;
        float width = (float)tilewidth / (float)imagewidth;
        float xOffset = (float)(1 + (i % tileWidthCount) + (i % tileWidthCount)*tilewidth) / (float)imagewidth;
        float yOffset = 1-(float)(1 + (i / tileWidthCount) + (i / tileWidthCount)*tileheight) / (float)imageheight - height;
        CGRect rect = CGRectMake(xOffset, yOffset, width, height);
        SKTexture *tile = [SKTexture textureWithRect:rect inTexture:tileTexture];
        [tiles addObject:tile];
    }
    
    SKSpriteNode *qwe = [SKSpriteNode spriteNodeWithTexture:tiles[1]];
    qwe.position = CGPointMake(400, 400);
//    [self addChild:qwe];
    
    NSDictionary *layer = layers[0];
    int layerHeight = [[layer objectForKey:@"height"] integerValue];
    int layerWidth = [[layer objectForKey:@"width"] integerValue];
    NSArray *layerData = [layer objectForKey:@"data"];
    NSMutableArray *layerTiles = [NSMutableArray arrayWithCapacity:[layerData count]];
    
    for (int i = 0; i < [layerData count]; i++) {
        int tileIndex = [layerData[i] integerValue];
        SKSpriteNode *tile = [SKSpriteNode spriteNodeWithTexture:tiles[tileIndex-1]];
        int xOffset = (i % layerWidth) * tilewidth;
        int yOffset = (i / layerWidth) * tileheight;
        tile.position = CGPointMake(xOffset, self.size.height - yOffset);
        [layerTiles addObject:tile];
    }
    
    SKNode *ground = [SKNode node];
    
    for (int i = 0; i < [layerTiles count]; i++) {
        [ground addChild:layerTiles[i]];
    }
    ground.zPosition  = 10;
    ground.position = CGPointMake(DEFAULT_CELL_SIZE * DEFAULT_COLS + 16, 0);
    [self addChild:ground];
}

























@end
