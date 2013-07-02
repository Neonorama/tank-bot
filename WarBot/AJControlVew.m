//
//  AJControlVew.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJControlVew.h"
#import "AJConstants.h"

@implementation AJControlVew

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(200, 200, 200, 200) width:DEFAULT_CELL_SIZE*DEFAULT_COLS height:winSize.height];
        
        [self addChild:background z:-1 tag:1001];
        
        self.available = [NSMutableArray array];
        self.program = [NSMutableArray array];
        
        self.touchEnabled = YES;
    }
    return self;
}

-(void)showProg {
    int xOffset, yOffset;
    NSDictionary *prog = self.gameManager.programField.commands;
//    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    for (int i = 0; i < prog.count; i++) {

        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
    
        CGPoint position = ccp(xOffset, yOffset);
        position = [[CCDirector sharedDirector] convertToGL:position];
        AJCommand *command = [prog objectForKey:[NSString stringWithFormat:@"%d",i]];
        CCSprite *commandSprite = [self getCommandSprite: command];
        commandSprite.position = position;
        
        [self addChild:commandSprite z:1 tag:1002];

    }
}

-(void)showAvailable {
    int xOffset, yOffset;
    NSArray *prog = self.gameManager.availableCommands.availableCommands;
//    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    for (int i = 0; i < prog.count; i++) {
        
        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2 + (self.gameManager.programField.commands.count / DEFAULT_COLS + 1) * DEFAULT_CELL_SIZE;
        
        CGPoint position = ccp(xOffset, yOffset);
        position = [[CCDirector sharedDirector] convertToGL:position];
        AJCommand *command = prog[i];
        CCSprite *commandSprite = [self getCommandSprite: command];
        commandSprite.position = position;
        
        NSMutableDictionary *available = [[NSMutableDictionary alloc] initWithCapacity:2];
        [available setObject:command forKey:@"command"];
        [available setObject:commandSprite forKey:@"sprite"];
        
        [self.available addObject:available];
        
        [self addChild:commandSprite z:1 tag:1003];
        
    }
}

-(CCSprite *) getCommandSprite: (AJCommand *) command {
    CCSprite *commandSprite;
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [command.param intValue]] fontName:@"Arial" fontSize:10];
    label.position = ccp(10, 10);
    
    
    if ([command.command isEqualToString:kCommandMoveForward]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"move_forward.png"];
        
    } else if ([command.command isEqualToString:kCommandMoveBackward]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"move_backward.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnLeft]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"turn_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnRight]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"turn_right.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretLeft]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"turn_canon_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretRight]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"turn_canon_right.png"];
        
    } else if ([command.command isEqualToString:kCommandJump]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"func.png"];
        
    } else if ([command.command isEqualToString:kCommandRet]) {
        commandSprite = [CCSprite spriteWithSpriteFrameName:@"ret.png"];
        
    } else {
        commandSprite = [CCLayerColor layerWithColor:ccc4(10, 10, 10, 255) width:32 height:32];
//        commandSprite.anchorPoint = ccp(-1.0, -1.0);
    }
    
    [commandSprite addChild:label];
    return commandSprite;
}

-(void)update:(ccTime)delta {
    ;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
        
    CGPoint touchLocationOne =  [self convertTouchToNodeSpace:touchOne];
    
    for (NSDictionary *command in self.available)
    {
        if (CGRectContainsPoint(((CCSprite *)[command objectForKey:@"sprite"]).boundingBox, touchLocationOne))
        {
            NSLog(@"Found command: %@", [command objectForKey:@"command"]);
        }
    }
}


@end
