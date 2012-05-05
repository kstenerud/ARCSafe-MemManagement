//
//  ViewController.m
//  ARCExample
//
//  Created by Karl Stenerud on 4/29/12.
//

#import "ViewController.h"
#import "ARCSafe_MemMgmt.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize weakProp = _weakProp;
@synthesize strongProp = _strongProp;
@synthesize retainProp = _retainProp;

- (void) dealloc
{
    // You must do this to avoid a memory leak when compiling for non-ARC.
    // In ARC mode, these macros do nothing.
    as_release(_strongProp);
    as_release(_retainProp);
    as_superdealloc();
}

- (BOOL) doSomethingWithError:(NSError* as_autoreleasing *) error
{
    // Very contrived example with bridging to/from Core Foundation.
    if(error != nil)
    {
        NSString* domain = @"whatever";
        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:@"Something broke!" forKey:NSLocalizedDescriptionKey];
        
        // Bridge from Objective-C to Core Foundation.
        CFErrorRef errorRef = CFErrorCreate(NULL, (as_bridge CFStringRef)domain, 1, (as_bridge CFDictionaryRef)userInfo);
        
        // Bridge from Core Foundation to Objective-C.
        // Remember to autorelease for non-ARC!
        *error = as_autorelease((as_bridge NSError*)errorRef);
    }
    
    return NO;
}

- (void) setRetainProp:(NSString *)retainProp
{
    // Use as_autorelease_noref() instead of as_autorelease() to avoid a
    // compiler warning.
    as_autorelease_noref(_retainProp);
    _retainProp = as_retain(retainProp);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    as_autoreleasepool_start(pool);
    
    // One minor annoyance is that the preprocessor gets confused by commas
    // in Objective-C code.
    NSString* tempString = [[NSString alloc] initWithFormat:@"Test strong prop %d", 1000];
    self.strongProp = as_autorelease(tempString);

    self.retainProp = [NSString stringWithFormat:@"Test retain prop %.1f", 0.1];
    
    // Note: In ARC mode, self.weakProp will become nil once the autorelease
    // pool ends. in non-ARC mode, it will become a dangling pointer!
    self.weakProp = [NSString stringWithFormat:@"Test weak prop %d", 0];
    
    as_autoreleasepool_end(pool);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"Strong property = %@", self.strongProp);
    NSLog(@"Retain property = %@", self.retainProp);
    if(self.weakProp == nil)
    {
        NSLog(@"Weak property is nil");
    }
    else
    {
        NSLog(@"\"Weak\" property is non-nil");
    }
    
    // Storage qualifier autoreleasing avoids creation of a temp variable
    // when passing by reference in ARC.
    NSError* as_autoreleasing error;
    BOOL result = [self doSomethingWithError:&error];
    NSLog(@"Result = %d, error = %@", result, error);
}

@end
