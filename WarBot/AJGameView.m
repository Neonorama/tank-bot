//
//  AJGameView.m
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameView.h"

#define PATH_LENGTH 48
#define PointUP(CGPoint)    CGPointMake(CGPoint.x,CGPoint.y + 1)
#define PointRight(CGPoint) CGPointMake(CGPoint.x + 1,CGPoint.y)
#define PointDown(CGPoint)  CGPointMake(CGPoint.x,CGPoint.y - 1)
#define PointLeft(CGPoint)  CGPointMake(CGPoint.x - 1,CGPoint.y)

@implementation AJGameView

-(id)initWithSize:(CGSize)size name:(NSString *)levelName
{
    if (self = [super init]) {
        self.size = size;
        if ([levelName isEqualToString:@"random"]) {
            [self generateRandomLevel];
        } else {
            [self generateLevel:levelName];
        }
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

-(void)generateRandomLevel {
    SKTextureAtlas *levelObjects = [SKTextureAtlas atlasNamed:@"level_objects.atlas"];
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground.png"];
    
    ground.anchorPoint = CGPointMake(0, 0);
    [self addChild:ground];
    
    // Поле 11 х 12
    // Выбираем начальную точку случайным образом
    int randStart = arc4random() % (11 *12); //
    int startX = randStart % 11;
    int startY = randStart / 11;
    
    self.startPoint = CGPointMake(64 * startX +32, 64 * startY +32);
    
    // Делаем PATH_LENGTH шага пути для 100% прохождения уровня
    NSMutableArray *pathPoints = [NSMutableArray arrayWithCapacity:PATH_LENGTH];
    CGPoint startPoint = CGPointMake(startX, startY);
    
    [pathPoints addObject:[NSValue valueWithCGPoint:startPoint]];
    
    CGPoint nextPoint = startPoint;
    CGPoint currPoint = startPoint;
    for (int i = 1; i < PATH_LENGTH; i++) {
       
        do {
            // проверяем точку внутри поля
            if ((currPoint.x > 0 && currPoint.x < 10) && (currPoint.y > 0 && currPoint.y < 11)) {
                int dir = arc4random() % 4 + 1; // выбираем направление 1 - вверх, 2 - вправо, 3 - вниз, 4 - влево
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    case 3:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    case 4:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    default:
                        break;
                }
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointLeft(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointRight(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
        
            // точка на левой границе
            if ((currPoint.x == 0) && (currPoint.y > 0 && currPoint.y < 11)) {
                int dir = arc4random() % 3+ 1; // выбираем направление 1 - вверх, 2 - вправо, 3 - вниз
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    case 3:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    default:
                        break;
                }
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointRight(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // точка на правой границе
            if ((currPoint.x == 10) && (currPoint.y > 0 && currPoint.y < 11)) {
                int dir = arc4random() % 3+ 1; // выбираем направление 1 - вверх, 2 - вниз, 3 - влево
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    case 3:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    default:
                        break;
                }
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointLeft(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // точка на верхней границе
            if ((currPoint.x > 0 && currPoint.x < 10) && (currPoint.y == 11)) {
                int dir = arc4random() % 3+ 1; // выбираем направление 1 - вправо, 2 - вниз, 3 - влево
                switch (dir) {
                        
                    case 1:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    case 3:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    default:
                        break;
                }
                
                if  ([self point:PointLeft(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointRight(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // точка на нижней границе
            if ((currPoint.x > 0 && currPoint.x < 10) && (currPoint.y == 0)) {
                int dir = arc4random() % 3+ 1; // выбираем направление 1 - вверх, 2 - вправо, 3 - влево
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    case 3:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    default:
                        break;
                }
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointLeft(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointRight(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // 0,0
            if ((currPoint.x == 0) && (currPoint.y == 0)) {
                int dir = arc4random() % 2+ 1; // выбираем направление 1 - вверх, 2 - вправо
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    default:
                        break;
                };
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointRight(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // 10,0
            if ((currPoint.x == 10) && (currPoint.y == 0)) {
                int dir = arc4random() % 2+ 1; // выбираем направление 1 - вверх, 2 - влево
                switch (dir) {
                    case 1:
                        nextPoint = PointUP(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    default:
                        break;
                };
                
                if ([self point:PointUP(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointLeft(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // 10,11
            if ((currPoint.x == 10) && (currPoint.y == 11)) {
                int dir = arc4random() % 2+ 1; // выбираем направление 1 - влево, 2 - вниз
                switch (dir) {
                    case 1:
                        nextPoint = PointLeft(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    default:
                        break;
                };
                
                if ([self point:PointLeft(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            // 0,11
            if ((currPoint.x == 0) && (currPoint.y == 11)) {
                int dir = arc4random() % 2+ 1; // выбираем направление 1 - вниз, 2 - вправо
                switch (dir) {
                    case 1:
                        nextPoint = PointDown(currPoint);
                        break;
                        
                    case 2:
                        nextPoint = PointRight(currPoint);
                        break;
                        
                    default:
                        break;
                };
                
                if ([self point:PointRight(currPoint) existsInPathPoints:pathPoints] &&
                    [self point:PointDown(currPoint) existsInPathPoints:pathPoints]) {
                    break;
                }
            };
            
            
        } while ([self point:nextPoint existsInPathPoints:pathPoints]);
        
        [pathPoints addObject:[NSValue valueWithCGPoint:nextPoint]];
        
        currPoint = nextPoint;
        
    }
    
//    [pathPoints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        CGPoint p = [obj CGPointValue];
//        
//        SKSpriteNode *ttt = [SKSpriteNode spriteNodeWithTexture:[levelObjects textureNamed:@"box1.png"]];
//        ttt.position = CGPointMake(64 * p.x +32, 64 * p.y +32);
//        [self addChild:ttt];
//    }];
    
    
    for (int i = 0; i < 11; i ++) {
        for (int j = 0; j < 12; j++) {
            CGPoint point = CGPointMake(i, j);
            
            if (![self point:point existsInPathPoints:pathPoints]) {

                SKTexture *texture;
                int rnd = arc4random() % 15;
                BOOL place = YES;
                switch (rnd) {
                    case 0:
                        texture = [levelObjects textureNamed:@"barrel1.png"];
                        break;
                    case 1:
                        texture = [levelObjects textureNamed:@"box3.png"];
                        break;
                    case 2:
                        texture = [levelObjects textureNamed:@"bush.png"];
                        break;
                    case 3:
                        texture = [levelObjects textureNamed:@"box1.png"];
                        break;
                    case 4:
                        texture = [levelObjects textureNamed:@"barrel2.png"];
                        break;
                    case 5:
                        texture = [levelObjects textureNamed:@"box2.png"];
                        break;
                    case 7:
                        texture = [levelObjects textureNamed:@"box4.png"];
                        break;
                        
                    default:
                        place = NO;
                        break;
                }
                
                if (place) {
                    SKPhysicsBody *physics = [SKPhysicsBody bodyWithCircleOfRadius:5.0f];
                    SKSpriteNode *levelObject = [SKSpriteNode spriteNodeWithTexture:texture];
                    
                    physics.categoryBitMask = wallCategory;
                    physics.collisionBitMask = 0;
                    physics.contactTestBitMask = botCategory | bulletCategory;
                    levelObject.physicsBody = physics;
                    levelObject.position = CGPointMake(64 * point.x +32, 64 * point.y +32);
                    [self addChild:levelObject];
                }
            }
        }
    }
    
    
    self.finishArea  = CGRectMake(64 * nextPoint.x +32, 64 * nextPoint.y +32, 5, 5);
    
    [self putFinishInRect:self.finishArea];
}

-(BOOL)point:(CGPoint) point existsInPathPoints: (NSMutableArray *)points {
    __block BOOL exists = NO;
    [points enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (CGPointEqualToPoint(point, [obj CGPointValue])) {
            exists = YES;
        }
    }];
    
    return exists;
}

-(void) putFinishInRect: (CGRect)rect {
    
    SKShapeNode * finishShape = [SKShapeNode node];
    
    CGMutablePathRef finishPath = CGPathCreateMutable();
    CGPathAddRect(finishPath, NULL, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    finishShape.path = finishPath;
    //    finishShape.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
    //    finishShape.fillColor = [SKColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.5];
    finishShape.lineWidth = 0.0;
//    finishShape.zPosition = 10;
    finishShape.position = CGPointMake(rect.origin.x, rect.origin.y);
    finishShape.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:finishPath];
    finishShape.physicsBody.categoryBitMask = finishCategory;
    finishShape.physicsBody.collisionBitMask = 0;
    finishShape.physicsBody.contactTestBitMask = botCategory;
    [self addChild:finishShape];
    
    SKSpriteNode *finishSprite = [SKSpriteNode spriteNodeWithImageNamed:@"flag.png"];
    finishSprite.position = CGPointMake(finishShape.position.x + finishShape.frame.size.height / 2, finishShape.position.y + finishShape.frame.size.width / 2);
    finishSprite.zPosition = finishShape.zPosition + 1;
    finishShape.xScale = 0.8;
    finishShape.yScale = 0.8;
    [self addChild:finishSprite];
    
}

-(void)generateLevel:(NSString *)levelName {
    NSError *error;
    NSString *levelFileName = [[NSBundle mainBundle] pathForResource:levelName ofType:@"json"];
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
    
    NSArray *walls = [NSArray arrayWithArray:wall[@"objects"]];
    [walls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGMutablePathRef wallPath = CGPathCreateMutable();
        [self createPathRefFromArrayOfPoint:obj[@"polygon"] path: wallPath];
        
        SKShapeNode * wallPart = [SKShapeNode node];
        wallPart.path = wallPath;
//        wallPart.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
//        wallPart.fillColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
        wallPart.lineWidth = 0.0;
//        wallPart.zPosition = 10;
        wallPart.position = CGPointMake([obj[@"x"] integerValue], self.size.height - [obj[@"y"] integerValue]);
        wallPart.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:wallPath];
        wallPart.physicsBody.categoryBitMask = wallCategory;
        wallPart.physicsBody.collisionBitMask = 0;
        wallPart.physicsBody.contactTestBitMask = botCategory | bulletCategory;
        
        [self addChild:wallPart];
        CGPathRelease(wallPath);
    }];
    
//    SKPhysicsBody *testWall = [SKPhysicsBody bodyWithEdgeLoopFromPath:wallPath];
//    SKNode *wall1 = [SKNode node];
//    wall1.physicsBody = testWall;
    
    // Generate start and finish area
    
    NSDictionary __block *start;
    NSDictionary __block *finish;
    NSMutableArray __block *barrels = [NSMutableArray array];
    
    [goals[@"objects"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"name"] isEqualToString:@"start"] ) {
            start = (NSDictionary *)obj;
        }
        if ([obj[@"name"] isEqualToString:@"finish"] ) {
            finish = (NSDictionary *)obj;
        }
        if ([obj[@"name"] isEqualToString:@"barrel"] ) {
            [barrels addObject:(NSDictionary *)obj];
        }
    }];
    
    [barrels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKSpriteNode *barrel = [SKSpriteNode spriteNodeWithImageNamed:@"oil_tank.png"];
        barrel.position = CGPointMake([obj[@"x"] integerValue], self.size.height - [obj[@"y"] integerValue]);
        barrel.zPosition = 1;
        barrel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        barrel.physicsBody.categoryBitMask = goalCategory;
        barrel.physicsBody.collisionBitMask = botCategory | bulletCategory;
        barrel.physicsBody.contactTestBitMask = botCategory | bulletCategory;
        [self addChild:barrel];
        
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
    
    [self putFinishInRect:finishArea];
    
    // Load tiles
//    int layerHeight = [[layer objectForKey:@"height"] integerValue];
//    int layerWidth = [[layer objectForKey:@"width"] integerValue];
    NSArray *layerData = [layer objectForKey:@"data"];
    NSMutableArray *layerTiles = [NSMutableArray arrayWithCapacity:[layerData count]];
    
    for (int i = 0; i < [layerData count]; i++) {
        int tileIndex = [layerData[i] integerValue];
        SKSpriteNode *tile = [SKSpriteNode spriteNodeWithTexture:tiles[tileIndex-1]];
//        int xOffset = (i % layerWidth) * tilewidth;
//        int yOffset = (i / layerWidth) * tileheight;
        
//        tile.position = CGPointMake(xOffset, yOffset);
        tile.position = CGPointMake(tilewidth / 2, tileheight / 2);
        [layerTiles addObject:tile];
    }
    
    SKNode *ground = [SKNode node];
    
    for (int i = 0; i < [layerTiles count]; i++) {
        [ground addChild:layerTiles[i]];
    }
//    ground.zPosition  = 1;
//    ground.position = CGPointMake(16, -16);
    ground.position = CGPointMake(0, 0);
    [self addChild:ground];
}

-(void) createPathRefFromArrayOfPoint:(NSArray *) pointsArray path: ( CGMutablePathRef) path{
    
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
}

- (void) clean {
    [self removeAllActions];
    [self removeAllChildren];
}

-(void)dealloc {
    
}

























@end
