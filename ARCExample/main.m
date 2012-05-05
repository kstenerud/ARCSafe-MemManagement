//
//  main.m
//  ARCExample
//
//  Created by Karl Stenerud on 4/29/12.
//

#import <UIKit/UIKit.h>
#import "ARCSafe_MemMgmt.h"

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    as_autoreleasepool_start(pool);

    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    
    as_autoreleasepool_end(pool);
}
