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
    if (self = [super init]) {
        self.size = size;
        [self generateLevel:@"testLevel"];
        
        
	}
	return self;
}

-(void)nextStep:(NSTimeInterval)delta{
    
    [self.gameManager nextStep];
}

- (void) reset {
    [self.gameManager reset];
    [self.gameManager.bot.chassis runAction:[SKAction moveTo:self.startPoint duration:0.0]];
    [self.gameManager.bot.chassis  runAction:[SKAction rotateToAngle:0.0 duration:0.0]];
    [self.gameManager.bot.turret  runAction:[SKAction rotateToAngle:0.0 duration:0.0]];
    [self.gameManager.registers setParam:@0 toRegister:kRegistersB];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    NSArray* allTouches = [[event allTouches] allObjects];
//    
//    UITouch* touchOne = [allTouches objectAtIndex:0];
    
//    CGPoint touchLocationOne = [touchOne locationInView:self.view];
//    
//    NSLog(@"Game view touch %@", NSStringFromCGPoint(touchLocationOne));
}

-(void)generateLevel:(NSString *)levelName {
    NSError *error;
    NSString *levelFileName = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"json"];
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
    
    NSDictionary __block *layer;
    NSDictionary __block *wall;
    NSDictionary __block *goals;
    
    [layers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"name"] isEqualToString:@"ground"] ) {
            layer = (NSDictionary *)obj;
        }
        if ([obj[@"name"] isEqualToString:@"wall"] ) {
            wall = (NSDictionary *)obj;
        }
        if ([obj[@"name"] isEqualToString:@"goals"] ) {
            goals = (NSDictionary *)obj;
        }
    }];
    
    // Generate walls
    
    NSArray *walls = [NSArray arrayWithArray:[wall objectForKey:@"objects"]];
    [walls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGPathRef wallPath = [self createPathRefFromArrayOfPoint:[obj objectForKey:@"polygon"]];
        
        SKShapeNode * wallPart = [SKShapeNode node];
        wallPart.path = wallPath;
        wallPart.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        wallPart.fillColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        wallPart.lineWidth = 1.0;
        wallPart.zPosition = 200;
        wallPart.position = CGPointMake([[obj objectForKey:@"x"] integerValue], self.size.height - [[obj objectForKey:@"y"] integerValue]);
        wallPart.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:wallPath];
        wallPart.physicsBody.categoryBitMask = wallCategory;
        wallPart.physicsBody.collisionBitMask = botCategory | wallCategory;
        wallPart.physicsBody.contactTestBitMask = botCategory | wallCategory;
        
        [self addChild:wallPart];
    }];
    
//    SKPhysicsBody *testWall = [SKPhysicsBody bodyWithEdgeLoopFromPath:wallPath];
//    SKNode *wall1 = [SKNode node];
//    wall1.physicsBody = testWall;
    
    // Generate start and finish area
    
    NSDictionary __block *start;
    NSDictionary __block *finish;
    
    [goals[@"objects"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"name"] isEqualToString:@"start"] ) {
            start = (NSDictionary *)obj;
        }
        if ([obj[@"name"] isEqualToString:@"finish"] ) {
            finish = (NSDictionary *)obj;
        }
    }];

    CGRect startArea = CGRectMake([start[@"x"] integerValue],
                                  self.size.height - [start[@"y"] integerValue] - [start[@"height"] integerValue],
                                  [start[@"width"] integerValue],
                                  [start[@"height"] integerValue]);
    
    CGRect finishArea = CGRectMake([finish[@"x"] integerValue],
                                  self.size.height - [finish[@"y"] integerValue] - [finish[@"height"] integerValue],
                                  [finish[@"width"] integerValue],
                                  [finish[@"height"] integerValue]);

    self.startPoint = CGPointMake(CGRectGetMidX(startArea), CGRectGetMidY(startArea)) ;
    
    SKShapeNode * finishShape = [SKShapeNode node];
    
    CGMutablePathRef finishPath = CGPathCreateMutable();
    CGPathAddRect(finishPath, NULL, CGRectMake(0, 0, finishArea.size.width, finishArea.size.height));
//    CGPathAddArc(finishPath, NULL, 0,0, 50, 0, M_PI*2, YES);
    
    finishShape.path = finishPath;
    finishShape.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
    finishShape.fillColor = [SKColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.5];
    finishShape.lineWidth = 1.0;
    finishShape.zPosition = 300;
    finishShape.position = CGPointMake(100, 200);// CGPointMake(finishArea.origin.x, finishArea.origin.y);
    finishShape.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:finishPath];
    finishShape.physicsBody.categoryBitMask = finishCategory;
    finishShape.physicsBody.collisionBitMask = botCategory | finishCategory;
    finishShape.physicsBody.contactTestBitMask = botCategory | finishCategory;
    [self addChild:finishShape];
    
    // Load tiles
//    int layerHeight = [[layer objectForKey:@"height"] integerValue];
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
    ground.position = CGPointMake(16, -16);
    [self addChild:ground];
}

-(CGPathRef) createPathRefFromArrayOfPoint:(NSArray *) pointsArray {
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (pointsArray && pointsArray.count > 0) {
        NSDictionary *val = [pointsArray objectAtIndex:0];
        CGPoint p = CGPointMake([val[@"x"] integerValue], [val[@"y"] integerValue]);
        CGPathMoveToPoint(path, nil, p.x, p.y);
        for (int i = 1; i < pointsArray.count; i++) {
            NSDictionary *val = [pointsArray objectAtIndex:i];
            CGPoint p = CGPointMake([val[@"x"] integerValue], [val[@"y"] integerValue] * -1);
            CGPathAddLineToPoint(path, nil, p.x, p.y);
        }
    }
    
    return path;
}


























@end
