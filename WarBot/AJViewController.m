//
//  AJViewController.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 11.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJViewController.h"
#import "AJStateController.h"
#import "AJGameManager.h"

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AJGameManager *testGM = [[AJGameManager alloc] init];

    for (int i = 0; i < DEFAULT_PROGRAM_LENGTH; i++) {
//        NSLog(@"%@", testGM.bot);
        [testGM nextStep];
    }
    
//    NSLog(@"Bot state: %@", testGM.bot);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
