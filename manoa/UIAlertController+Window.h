//
//  UIAlertController+Window.h
//  manoa
//
//  Created by Emiliano Miranda on 4/25/17.
//
//  This solution was derived from "agilityvision" in the post http://stackoverflow.com/questions/26554894/how-to-present-uialertcontroller-when-not-in-a-view-controller
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UIAlertController (Window)

- (void)show;
- (void)show:(BOOL)animated;

@end

@interface UIAlertController (Private)

@property(nonatomic, strong) UIWindow* alertWindow;

@end
