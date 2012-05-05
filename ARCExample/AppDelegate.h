//
//  AppDelegate.h
//  ARCExample
//
//  Created by Karl Stenerud on 4/29/12.
//

#import <UIKit/UIKit.h>
#import "ARCSafe_MemMgmt.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (as_strongprop, nonatomic) UIWindow *window;

@property (as_strongprop, nonatomic) ViewController *viewController;

@end
