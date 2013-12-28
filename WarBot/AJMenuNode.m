//
//  AJMenuNode.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 01.12.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJMenuNode.h"

@implementation AJMenuNode

-(id)init {
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

-(id)initLabelWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void (^)(void))block {
    self = [super init];
    if (self) {
        self.label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.label.text = text;
        self.label.fontSize = size;
        self.label.position = position;
        self.label.name = name;
        self.label.zPosition = 10;
        [self addChild: self.label];
        self.block = block;
        self.name = name;
    }
    return self;
}

-(id)initSpriteWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void (^)(void))block {
    self = [super init];
    if (self) {
        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:name];
        self.sprite.position = position;
        self.sprite.name = name;
        self.sprite.zPosition = 10;
        [self addChild: self.sprite];
        self.block = block;
        self.name = name;
    }
    return self;
}

+(AJMenuNode *)menuLabelNodeWithName:(NSString *)name text:(NSString *)text position:(CGPoint)position size:(int)size block:(void (^)(void))block {
    return [[self alloc] initLabelWithName:name text:text position:position size:size block: block];
}

+(AJMenuNode *)menuSpriteNodeWithName:(NSString *)name position:(CGPoint)position size:(int)size block:(void (^)(void))block {
    return [[self alloc] initSpriteWithName:name position:position size:size block:block];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self.parent];
    
    if ([[self childNodeWithName:self.name] containsPoint:touchLocationOne]) {
        self.block();
    }
}


@end
