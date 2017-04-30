//
//  UIAlertController+Window.h
//  manoa
//
//  Created by Emiliano Miranda on 4/25/17.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UIAlertController (Window)

- (void)show;
- (void)show:(BOOL)animated;

@end

@interface UIAlertController (Private)

@property (nonatomic, strong) UIWindow* alertWindow;

@end
