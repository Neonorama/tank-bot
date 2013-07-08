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

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
//        self.backgroundColor = [SKColor colorWithRed:0.3 green:0.4 blue:0.1 alpha:0.8];
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.8] size:CGSizeMake(DEFAULT_CELL_SIZE*DEFAULT_COLS, size.height)];
        ground.anchorPoint = CGPointMake(0, 0);
        self.available = [NSMutableArray array];
        self.program = [NSMutableArray array];
        self.intermediateCommand = nil;
        
        [self addChild:ground];
    }
    return self;
}

-(void)showProg {
    int xOffset, yOffset;
    NSDictionary *prog = self.gameManager.programField.commands;
    
    for (int i = 0; i < prog.count; i++) {

        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
    
        CGPoint position = CGPointMake(xOffset, self.size.height - yOffset);
        AJCommand *command = [prog objectForKey:[NSString stringWithFormat:@"%d",i]];
        SKSpriteNode *commandSprite = [self getCommandSprite: command];
        commandSprite.position = position;

        NSMutableDictionary *commandTMP = [[NSMutableDictionary alloc] initWithCapacity:2];
        [commandTMP setObject:command forKey:@"command"];
        [commandTMP setObject:commandSprite forKey:@"sprite"];
        
        [self.program addObject:commandTMP];
        
        [self addChild:commandSprite];

    }
}

-(void)showAvailable {
    int xOffset, yOffset;
    NSArray *prog = self.gameManager.availableCommands.availableCommands;
    
    for (int i = 0; i < prog.count; i++) {
        
        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2 + (self.gameManager.programField.commands.count / DEFAULT_COLS + 1) * DEFAULT_CELL_SIZE + 20;
        
        CGPoint position = CGPointMake(xOffset, self.size.height - yOffset);
        position = CGPointMake(position.x, position.y);
        AJCommand *command = prog[i];
        SKSpriteNode *commandSprite = [self getCommandSprite: command];
        commandSprite.position = position;
        
        NSMutableDictionary *available = [[NSMutableDictionary alloc] initWithCapacity:2];
        [available setObject:command forKey:@"command"];
        [available setObject:commandSprite forKey:@"sprite"];
        
        [self.available addObject:available];
        [self addChild:commandSprite];
        
    }
}

-(SKSpriteNode *) getCommandSprite: (AJCommand *) command {
    SKSpriteNode *commandSprite;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    label.fontSize = 10;
    label.fontColor = [SKColor whiteColor];
    label.position = CGPointMake(10, 10);
    
    
    if ([command.command isEqualToString:kCommandMoveForward]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"move_forward.png"];
        
    } else if ([command.command isEqualToString:kCommandMoveBackward]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"move_backward.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnLeft]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"turn_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnRight]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"turn_right.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretLeft]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"turn_canon_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretRight]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"turn_canon_right.png"];
        
    } else if ([command.command isEqualToString:kCommandJump]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"func.png"];
        
    } else if ([command.command isEqualToString:kCommandRet]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"ret.png"];
        
    } else if ([command.command isEqualToString:kCommandDefault]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"defaultcmd.png"];
        
    } else {
        commandSprite = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(DEFAULT_CELL_SIZE, DEFAULT_CELL_SIZE)];
//        commandSprite.anchorPoint = ccp(-1.0, -1.0);
    }
    
    label.zPosition = 1;
    [commandSprite addChild:label];
    return commandSprite;
    return nil;
}

-(void)nextStep:(NSTimeInterval)delta {
    int index = [self.gameManager getCurrentCommandIndex];
    SKAction *scale1 = [SKAction scaleBy:1.2 duration:delta /2];
    SKAction *scale2 = [SKAction scaleTo:1 duration:delta /2];
    [[[self.program objectAtIndex:index] objectForKey:@"sprite"] runAction:[SKAction sequence:@[scale1, scale2]]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self.parent];
    
    NSLog(@"Control view touch %@", NSStringFromCGPoint(touchLocationOne));
    for (NSDictionary *command in self.available)
    {
        if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
        {
            self.intermediateCommand = [[command objectForKey:@"command"] copy];
            NSLog(@"Found available command: %@", [command objectForKey:@"command"]);
        }
    }
    
    for (NSDictionary *command in self.program)
    {
        if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
        {
            if (self.intermediateCommand) {
                [self.gameManager.programField replaceCommand:[command objectForKey:@"command"] to:self.intermediateCommand];
                self.intermediateCommand = nil;
                
            } else {
//                self.intermediateCommand = [command objectForKey:@"command"];
            }
            NSLog(@"Found program command: %@", [command objectForKey:@"command"]);
        }
    }
    [self removeAllChildren];
    [self.program removeAllObjects];
    [self.available removeAllObjects];


    SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:0.8] size:CGSizeMake(DEFAULT_CELL_SIZE*DEFAULT_COLS, self.size.height)];
    background.anchorPoint = CGPointMake(0, 0);
    
    [self addChild:background];

    [self showProg];
    [self showAvailable];
}


@end
