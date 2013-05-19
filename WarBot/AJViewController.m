//
//  AJViewController.m
//  WarBot
//
//  Created by Ilya Rezyapkin on 11.05.13.
//  Copyright (c) 2013 Ilya Rezyapkin. All rights reserved.
//

#import "AJViewController.h"
#import "AJBot.h"
#import "AJStateController.h"

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AJBot *testBot = [AJBot defaultBot];
//    AJStateController *stateController = [[AJStateController alloc] init];
//    testBot.stateController = stateController;
//    testBot.chassis.stateController = stateController;
//    testBot.turret.stateController = stateController;
    
    [testBot moveForward:20];
    [testBot turnLeft:90];
    [testBot turnTurret:45];
    [testBot turnTurretLeft:90];
    [testBot turnRight:45];
    [testBot moveBackward:50];
    [testBot turnLeft:45];
    [testBot fire];
    [testBot moveForward:50];
    [testBot turnRight:90];
    [testBot moveForward:50];
    [testBot turnRight:90];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
