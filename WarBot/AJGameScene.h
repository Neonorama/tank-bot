//
//  AJGameScene.h
//  WarBot
//
//  Created by Ilya Rezyapkin on 26.06.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"

#import "AJGameView.h"
#import "AJControlVew.h"
#import "AJGameManager.h"

@interface AJGameScene : CCScene

@property AJGameView *gameView;
@property AJControlVew *controlView;

+(CCScene *) scene;

@end
