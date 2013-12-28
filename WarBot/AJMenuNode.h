//
//  AJMenuNode.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 01.12.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef void (^MyBlock) (void);

@interface AJMenuNode : SKScene

@property (nonatomic, copy) MyBlock block;
@property (nonatomic, retain) SKLabelNode *label;
@property (nonatomic, retain) SKSpriteNode *sprite;
@property (nonatomic, retain) NSString *name;

-(id)initLabelWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void (^)(void))block;
-(id)initSpriteWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void (^)(void))block;

+(AJMenuNode *)menuLabelNodeWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void (^)(void))block;
+(AJMenuNode *)menuSpriteNodeWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void (^)(void))block;

@end
