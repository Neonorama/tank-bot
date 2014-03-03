//
//  AJControlVew.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJControlVew.h"
#import "AJConstants.h"

@implementation AJControlVew {
    __block BOOL touchEnabled;
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.available = [NSMutableArray array];
        self.program = [NSMutableArray array];
        self.registers = [NSMutableArray array];
        self.intermediateCommand = nil;
        self.intermediateSprite = [[SKSpriteNode alloc] init];
        touchEnabled = YES;
        [self createContent];
    }
    return self;
}

- (void) createContent {
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"command_background.png"];
    ground.anchorPoint = CGPointMake(0, 0);
    [self addChild:ground];
    
    SKLabelNode *progLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    progLabel.text = NSLocalizedString(@"Program field", nil);
    progLabel.fontSize = 16;
    progLabel.fontColor = [SKColor blackColor];
    progLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    progLabel.position = CGPointMake(10, self.size.height - 20);
    [self addChild:progLabel];
    
    SKLabelNode *availLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    availLabel.text = NSLocalizedString(@"Available commands", nil);
    availLabel.fontSize = 16;
    availLabel.fontColor = [SKColor blackColor];
    availLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    availLabel.position = CGPointMake(10, 255);
    [self addChild:availLabel];
    
    SKShapeNode *border1 = [SKShapeNode node];
    border1.path = CGPathCreateWithRect(CGRectMake(0, 0, 320, 100), nil);
    border1.strokeColor = [SKColor blackColor];
    border1.lineWidth = 2;
    [self addChild:border1];
    
    SKShapeNode *border2 = [SKShapeNode node];
    border2.path = CGPathCreateWithRect(CGRectMake(0, 100, 320, 180), nil);
    border2.strokeColor = [SKColor blackColor];
    border2.lineWidth = 2;
    [self addChild:border2];
    
    SKShapeNode *border3 = [SKShapeNode node];
    border3.path = CGPathCreateWithRect(CGRectMake(0, 280, 320, self.size.height - 280), nil);
    border3.strokeColor = [SKColor blackColor];
    border3.lineWidth = 2;
    [self addChild:border3];
}

- (void) showRegisters {
    for (int i = 0; i < self.gameManager.registers.registers.count; i++) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier New"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = [self.gameManager.registers.registers[i] stringValue];
        
        label.position = CGPointMake(DEFAULT_CELL_SIZE * i / 2 + DEFAULT_CELL_SIZE / 2, 10);
        
//        [self addChild:label];
        [self.registers addObject:label];
    }
}

- (void) updateRegisters {
    for (int i = 0; i < self.registers.count; i++) {
        [(SKLabelNode *)self.registers[i] setText:[self.gameManager.registers.registers[i] stringValue]];
    }
}

-(void)showProg {
    int xOffset, yOffset;
    NSDictionary *prog = self.gameManager.programField.commands;
    
    for (int i = 0; i < prog.count; i++) {

        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2 + 25;
    
        CGPoint position = CGPointMake(xOffset, self.size.height - yOffset);
        AJCommand *command = [prog objectForKey:[NSString stringWithFormat:@"%d",i]];
        SKSpriteNode *commandSprite = [self getCommandSprite: command];
        commandSprite.position = position;

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        label.fontSize = 10;
        label.fontColor = [SKColor colorWithRed:68/255 green:148/255 blue:192/255 alpha:0.8];
        label.text = [NSString stringWithFormat: @"%d",i ];
        label.position = CGPointMake(-14, -24);
        label.name = @"index";
        [commandSprite addChild:label];
        
        [self addChild:commandSprite];
        
        NSMutableDictionary *commandTMP = [[NSMutableDictionary alloc] initWithCapacity:2];
        [commandTMP setObject:command forKey:@"command"];
        [commandTMP setObject:commandSprite forKey:@"sprite"];
        
        [self.program addObject:commandTMP];

    }
}

-(void)showProgCellByIndex:(int)idx {
    
//    [self.program removeObjectAtIndex:idx];
    int xOffset, yOffset;
    NSDictionary *prog = self.gameManager.programField.commands;
        
    xOffset = (idx % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
    yOffset = (idx / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2 + 25;
    
    CGPoint position = CGPointMake(xOffset, self.size.height - yOffset);
    AJCommand *command = [prog objectForKey:[NSString stringWithFormat:@"%d",idx]];
    SKSpriteNode *commandSprite = [self getCommandSprite: command];
    commandSprite.position = position;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    label.fontSize = 10;
    label.fontColor = [SKColor colorWithRed:68/255 green:148/255 blue:192/255 alpha:0.8];
    label.text = [NSString stringWithFormat: @"%d", idx];
    label.position = CGPointMake(-14, -24);
    label.name = @"index";
    [commandSprite addChild:label];
    
    [self addChild:commandSprite];
    
    NSMutableDictionary *commandTMP = [[NSMutableDictionary alloc] initWithCapacity:2];
    [commandTMP setObject:command forKey:@"command"];
    [commandTMP setObject:commandSprite forKey:@"sprite"];
    
    self.program[idx] = commandTMP;
}

-(void)showAvailable {
    int xOffset, yOffset;
    NSArray *prog = self.gameManager.availableCommands.availableCommands;
    
    for (int i = 0; i < prog.count; i++) {
        
        xOffset = (i % DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2;
        yOffset = (i / DEFAULT_COLS) * DEFAULT_CELL_SIZE + DEFAULT_CELL_SIZE / 2 + (self.gameManager.programField.commands.count / DEFAULT_COLS + 1) * DEFAULT_CELL_SIZE + 70;
        
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
    SKSpriteNode *commandSprite = [[SKSpriteNode alloc] init];
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    label.fontSize = 10;
    label.fontColor = [SKColor whiteColor];
    label.text = [[command param] stringValue];
    label.name = @"param";
    label.position = CGPointMake(15, 12);
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"controls"];
    SKSpriteNode *commandSpriteBase = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_base.png"];
    
    if ([command.command isEqualToString:kCommandMoveForward]) {
        commandSprite = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"control_button_base_forward.png"]];
        
    } else if ([command.command isEqualToString:kCommandMoveBackward]) {
        commandSprite = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"control_button_base_backward.png"]];
        
    } else if ([command.command isEqualToString:kCommandTurnLeft]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_base_turn_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnRight]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_base_turn_right.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretLeft]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_tower_turn_left.png"];
        
    } else if ([command.command isEqualToString:kCommandTurnTurretRight]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_tower_turn_right.png"];
        
    } else if ([command.command isEqualToString:kCommandJump]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"func.png"];
        label.zPosition = 1;
        [commandSprite addChild:label];
        
    } else if ([command.command isEqualToString:kCommandFire]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"fire.png"];
        
    } else if ([command.command isEqualToString:kCommandRet]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"ret.png"];
        
    } else if ([command.command isEqualToString:kCommandDefault]) {
        commandSprite = [SKSpriteNode spriteNodeWithImageNamed:@"control_button_base.png"];
        
    } else {
        commandSprite = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(DEFAULT_CELL_SIZE, DEFAULT_CELL_SIZE)];
    }
    
//    label.zPosition = 1;
//    [commandSprite addChild:label];
    
    [commandSpriteBase addChild:commandSprite];
    return commandSpriteBase;
}

-(void)nextStep:(NSTimeInterval)delta {
    int index = [self.gameManager getCurrentCommandIndex];
    SKAction *scale1 = [SKAction scaleBy:1.2 duration:DEFAULT_TIME_INTERVAL /2];
    SKAction *scale2 = [SKAction scaleTo:1 duration:DEFAULT_TIME_INTERVAL /2];
    [[[self.program objectAtIndex:index] objectForKey:@"sprite"] runAction:[SKAction sequence:@[scale1, scale2]]];
    [self updateRegisters];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self.parent];
    
    if (touchEnabled) {
        for (NSDictionary *command in self.available)
        {
            if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
            {
                self.intermediateSprite = [(SKSpriteNode *)[command objectForKey:@"sprite"] copy];
                [self addChild:self.intermediateSprite];
                SKAction *scale = [SKAction scaleTo:1.5 duration:0.3];
                [self.intermediateSprite runAction:scale];
                
                self.intermediateCommand = [[command objectForKey:@"command"] copy];
            }
        }
        
        for (NSDictionary *command in self.program)
        {
            if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
            {
                self.intermediateSprite = [(SKSpriteNode *)[command objectForKey:@"sprite"] copy];
                [self addChild:self.intermediateSprite];
                SKAction *scale = [SKAction scaleTo:1.5 duration:0.3];
                [self.intermediateSprite runAction:scale];
                self.intermediateCommand = [[command objectForKey:@"command"] copy];
            }
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self.parent];
    
    self.intermediateSprite.position = touchLocationOne;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    SKAction *move = nil;
    NSArray* allTouches = [[event allTouches] allObjects];
    
    UITouch* touchOne = [allTouches objectAtIndex:0];
    
    CGPoint touchLocationOne = [touchOne locationInNode:self.parent];
    BOOL inProg = NO;
    
    for (NSDictionary *command in self.program)
    {
        if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
        {
            move = [SKAction moveTo:((SKSpriteNode *)[command objectForKey:@"sprite"]).position duration:0.2];
            if (self.intermediateCommand) {
                [self.gameManager.programField replaceCommand:[command objectForKey:@"command"] to:self.intermediateCommand];
                self.intermediateCommand = nil;
            }
            inProg = YES;
            SKAction *scale = [SKAction scaleTo:1.0 duration:0.2];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *group = [SKAction group:@[move, scale]];
            [self.intermediateSprite runAction:[SKAction sequence:@[group, remove]] completion:^{
                [self showProgCellByIndex:[self.program indexOfObject:command]];
            }];
        }
    }
    
    for (NSDictionary *command in self.available)
    {
        if (CGRectContainsPoint(((SKSpriteNode *)[command objectForKey:@"sprite"]).frame, touchLocationOne))
        {
            AJCommand *cmd =[command objectForKey:@"command"];
//            SKSpriteNode *cmdSprite = (SKSpriteNode *)[command objectForKey:@"sprite"];
            
            if ([cmd.command isEqualToString:kCommandJump]) {
                NSString *indexString = ((SKLabelNode *)[self.intermediateSprite childNodeWithName:@"index"]).text;
                cmd.param = [NSNumber numberWithInteger:[indexString integerValue]];
                NSLog(@"Jump command detect!!! %@", indexString);
            }
        }
    }
    
    if (!inProg) {
        SKAction *scale = [SKAction scaleTo:0.0 duration:0.2];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *group = [SKAction group:@[scale]];
        [self.intermediateSprite runAction:[SKAction sequence:@[group, remove]]];
        self.intermediateCommand = nil;
    }
    
    
//    [self performSelector:@selector(refresh) withObject:nil afterDelay:0.2];
    self.intermediateCommand = nil;
    
    touchEnabled = NO;
    [self runAction:[SKAction waitForDuration:0.3] completion:^{
        touchEnabled = YES;
    }];
}

- (void) refresh {
    [self removeAllChildren];
    [self.program removeAllObjects];
    [self.available removeAllObjects];
    [self.registers removeAllObjects];
    
    [self createContent];
    
    [self showProg];
    [self showAvailable];
    [self showRegisters];
}

- (void) cleanProg {
    [self.gameManager.programField removeAllCommands];

    [self refresh];
}

- (void) clean {
    [self removeAllActions];
    [self removeAllChildren];
}


@end
