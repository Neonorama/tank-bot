//
//  AJGameView.m
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameView.h"

@implementation AJGameView

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AJGameView *layer = [AJGameView node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
                
        self.gameManager = [[AJGameManager alloc] init];

		self.isTouchEnabled = YES;
        [self schedule:@selector(update:) interval:0.2];

	}
	return self;
}

-(void)update:(ccTime)dt{
    [self.gameManager nextStep];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* allTouches = [[event allTouches] allObjects];
    
    if (!isMoving) {
        for (UITouch *touch in allTouches) {
            CGPoint position = [touch locationInView:[touch view]];
            position = [[CCDirector sharedDirector] convertToGL:position];
        }
    }
    isMoving = NO;
}



-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{    

}


-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    isMoving = YES;
    
    NSArray* allTouches = [[event allTouches] allObjects];
    
    if ([allTouches count] == 2) {
        // Get two of the touches to handle the zoom
        UITouch* touchOne = [allTouches objectAtIndex:0];
        UITouch* touchTwo = [allTouches objectAtIndex:1];
        
        // Get the touches and previous touches.
        CGPoint touchLocationOne = [touchOne locationInView: [touchOne view]];
        CGPoint touchLocationTwo = [touchTwo locationInView: [touchTwo view]];
        
        CGPoint previousLocationOne = [touchOne previousLocationInView: [touchOne view]];
        CGPoint previousLocationTwo = [touchTwo previousLocationInView: [touchTwo view]];
        
        // Get the distance for the current and previous touches.
        CGFloat currentDistance = sqrt(
                                       pow(touchLocationOne.x - touchLocationTwo.x, 2.0f) +
                                       pow(touchLocationOne.y - touchLocationTwo.y, 2.0f));
        
        CGFloat previousDistance = sqrt(
                                        pow(previousLocationOne.x - previousLocationTwo.x, 2.0f) +
                                        pow(previousLocationOne.y - previousLocationTwo.y, 2.0f));
        
        // Get the delta of the distances.
        CGFloat distanceDelta = previousDistance - currentDistance;
        
        
        // Get the camera's current values.
        float centerX, centerY, centerZ;
        float eyeX, eyeY, eyeZ;
        [self.camera centerX:&centerX centerY:&centerY centerZ:&centerZ];
        [self.camera eyeX:&eyeX eyeY:&eyeY eyeZ:&eyeZ];
        
        eyeZ += distanceDelta * 2;
        if (eyeZ <= 1) {
            eyeZ = 1;
        }
        if (eyeZ >= 400) {
            eyeZ = 400;
        }
        
        // Set values.
        [self.camera setCenterX:centerX centerY:centerY centerZ:0];
        [self.camera setEyeX:eyeX eyeY:eyeY eyeZ:eyeZ];
    } else if ([allTouches count] == 1) {
        
        UITouch* touch = [allTouches objectAtIndex:0];
    
        CGPoint touchLocation = [touch locationInView: [touch view]];
        CGPoint prevLocation = [touch previousLocationInView: [touch view]];
        
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
        
        CGPoint diff = ccpSub(touchLocation,prevLocation);
        [self setPosition: ccpAdd(self.position, diff)];
        
        // Get the camera's current values.
        float centerX, centerY, centerZ;
        float eyeX, eyeY, eyeZ;
        [self.camera centerX:&centerX centerY:&centerY centerZ:&centerZ];
        [self.camera eyeX:&eyeX eyeY:&eyeY eyeZ:&eyeZ];
        
        // Increment panning value based on current zoom factor.
        diff.x = diff.x * (1+(eyeZ/1000));
        diff.y = diff.y * (1+(eyeZ/1000));
        
        // Round values to avoid subpixeling.
        int newX = centerX-round(diff.x);
        int newY = centerY-round(diff.y);
        
        // Set values.
        [self.camera setCenterX:newX centerY:newY centerZ:0];
        [self.camera setEyeX:newX eyeY:newY eyeZ:eyeZ];
    }
}

- (void) dealloc
{

}


@end
