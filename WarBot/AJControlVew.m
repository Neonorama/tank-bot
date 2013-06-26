//
//  AJControlVew.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJControlVew.h"

@implementation AJControlVew

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *t = [CCSprite spriteWithSpriteFrameName:@"move_forward.png"];
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(200, 200, 200, 200) width:64*6 height:winSize.height];
        
        [self addChild:background z:-1 tag:1001];
        [self addChild:t];
    }
    return self;
}

@end
