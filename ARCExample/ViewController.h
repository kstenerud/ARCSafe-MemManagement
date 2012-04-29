//
//  ViewController.h
//  ARCExample
//
//  Created by Karl Stenerud on 4/29/12.
//

#import <UIKit/UIKit.h>
#import "ARCSafe_MemMgmt.h"


/** This file and its corresponding .m file demonstrate how to use
 * ARCSafe_MemMgmt.h in your code.
 *
 * You can switch between ARC and non-ARC by changing the ARCExample target's
 * "Objective-C Automatic Reference Counting" build setting.
 */
@interface ViewController : UIViewController
{
    // Note: Weak references are not supported prior to iOS 5!
    NSString* as_weak weakValue;
    NSString* as_strong strongValue;
    NSString* as_unsafe_unretained unsafeUnretainedValue;
}
// Note: Weak references are not supported prior to iOS 5!
@property(as_weakprop, nonatomic, readwrite) NSString* weakProp;
@property(as_strongprop, nonatomic, readwrite) NSString* strongProp;
@property(retain, nonatomic, readwrite) NSString* retainProp;

- (BOOL) doSomethingWithError:(NSError* as_autoreleasing *) error;

@end
