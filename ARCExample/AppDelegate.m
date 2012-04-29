//
//  AppDelegate.m
//  ARCExample
//
//  Created by Karl Stenerud on 4/29/12.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    #pragma unused(application)
    #pragma unused(launchOptions)

    self.window = as_autorelease([[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]);
    self.viewController = as_autorelease([[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]);
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
