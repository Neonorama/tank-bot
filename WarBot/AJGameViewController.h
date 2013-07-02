//
//  AJGameViewController.h
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "CCViewController.h"
#import "AJGameScene.h"

@class AJGameViewController;

@protocol AJGameViewControllerDelegate
- (void)gameViewControllerDidFinish:(AJGameViewController *)controller;
@end

@interface AJGameViewController : CCViewController

@property (weak, nonatomic) id <AJGameViewControllerDelegate> delegate;
@property (nonatomic, strong) CCScene *gameScene;

- (IBAction)reset:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;


@end