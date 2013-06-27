//
//  CCViewController.h
//  CCViewController
//
//  Created by Jerrod Putman on 2/7/12.
//  Copyright (c) 2012 Tiny Tim Games. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "cocos2d.h"


// CCViewController is a UIViewController-derived class that can be used to insert a Cocos2D view into a navigation hierarchy.
// This is particularly useful when using Storyboards. Simply set the class of a view controller in your Storyboard to CCViewController (or your own custom derived class). When the view controller is presented, the Cocos2D director will fire up and begin rendering immediately. When you dismiss your controller, the director will be automatically disabled. You can even place UIKit elements onto your view controller in Interface Builder.


@interface CCViewController : UIViewController <CCDirectorDelegate>

#pragma mark - Setting up the director

// NOTE: If you have multiple CCViewController subclasses, you must take care the createDirectorGLView and didInitializeDirector set up the Cocos2D director exactly the same in each instance. Otherwise, you may get unexpected results. To avoid this, create another subclass that sits between CCViewController and your other subclasses, and place these methods there.

// Override this method to customize the CCGLView that is created for the director.
- (CCGLView *)createDirectorGLView;

// Override this method if you would like to set additional options for the director when it is first initialized.
// By default, this method does the following:
//  [director setAnimationInterval:1.0f/60.0f];
//  [director enableRetinaDisplay:YES];
- (void)didInitializeDirector;


#pragma mark - Notification handlers

// NOTE: You may override these as a convenient way to respond to application notifications. Be sure to call the super method to ensure director stability.

// Called when this view controller is visible and the application resigns active status.
- (void)applicationWillResignActive:(NSNotification *)notification;

// Called when this view controller is visible and the application becomes active.
- (void)applicationDidBecomeActive:(NSNotification *)notification;

// Called when this view controller is visible and the application enters the background.
- (void)applicationDidEnterBackground:(NSNotification *)notification;

// Called when this view controller is visible and the application enters the foreground.
- (void)applicationWillEnterForeground:(NSNotification *)notification;

// Called when this view controller is visible and the application is set to terminate.
- (void)applicationWillTerminate:(NSNotification *)notification;

// Called when this view controller is visible and the application reports a significant time change.
- (void)applicationSignificantTimeChange:(NSNotification *)notification;


@end
