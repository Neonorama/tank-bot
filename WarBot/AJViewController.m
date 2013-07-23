//
//  AJViewController.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 05.07.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJViewController.h"
#import "AJGameScene.h"

@interface AJViewController ()

@end

@implementation AJViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    
    SKView * skView = (SKView *)self.view;
    
    SKScene * scene = [AJGameScene sceneWithSize:CGSizeMake(1024,768)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}

-(BOOL)shouldAutorotate {
    return YES;
}

- (IBAction)pause:(id)sender {
    SKView * skView = (SKView *)self.view;
    AJGameScene *gameScene = (AJGameScene *)skView.scene;
    [gameScene pause];
}

- (IBAction)resume:(id)sender {
    SKView * skView = (SKView *)self.view;
    AJGameScene *gameScene = (AJGameScene *)skView.scene;
    [gameScene resume];
}

- (IBAction)nextStep:(id)sender {
    SKView * skView = (SKView *)self.view;
    AJGameScene *gameScene = (AJGameScene *)skView.scene;
    [gameScene next];
}
@end
