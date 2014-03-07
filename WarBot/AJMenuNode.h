//
//  AJMenuNode.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 01.12.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//typedef void (^MyBlock) (void);

@interface AJMenuNode : SKScene

{
	// used for menu items using a block
	void (^block_)(id sender);
    
	BOOL isEnabled_;
	BOOL isSelected_;
}

//@property (nonatomic, strong) MyBlock block;
@property (nonatomic, strong) SKLabelNode *label;
@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, copy) NSString *name;

-(id)initLabelWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void(^)(id sender))block;
-(id)initSpriteWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void(^)(id sender))block;

+(AJMenuNode *)menuLabelNodeWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void(^)(id sender))block;
+(AJMenuNode *)menuSpriteNodeWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void(^)(id sender))block;

-(void)addBackSprite:(SKSpriteNode *)ground;
@end
