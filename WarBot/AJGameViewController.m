//
//  AJGameViewController.m
//  Organizms
//
//  Created by Ilya Rezyapkin on 10.02.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJGameViewController.h"
#import "AJGameScene.h"

@interface AJGameViewController ()

@end

@implementation AJGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[CCDirector sharedDirector] pushScene:[AJGameScene scene]];
    
    CCScene *scene = [AJGameScene scene];
    AJGameView *layer = (AJGameView *) [scene.children objectAtIndex:0];
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:layer action:@selector(handlePanFrom:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [[CCDirector sharedDirector] pushScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reset:(id)sender {
    [self.delegate gameViewControllerDidFinish:self];
}

- (NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft |
    UIInterfaceOrientationMaskLandscapeRight;
}

@end
