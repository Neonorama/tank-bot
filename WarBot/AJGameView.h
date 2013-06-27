//
//  AJGameView.h
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"
#import "AJGameManager.h"

@interface AJGameView : CCLayer {
    BOOL isMoving;
}

@property AJGameManager *gameManager;
@property CCSprite *botBaseSprite;
@property CCSprite *botCanonSprite;

@end
