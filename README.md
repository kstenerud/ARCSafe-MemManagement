ARC-Safe Memory Management
==========================

By Karl Stenerud

### Makes your code both ARC and non-ARC compatible!


Introduction
------------

Automatic Reference Counting is awesome stuff, but it's going to take awhile for most
projects to fully make the transition. This can cause problems when using outside code,
especially when you have to mix and match ARC and non-ARC.

To make things easier for users of your code snippets, libraries and APIs, make them
compilable BOTH ways and let the user decide whether to use ARC or not!


Features
--------

- Ownership management macros
- Property and storage qualifiers
- Bridging between retainable and non-retainable pointers
- Autorelease pools


Usage
-----

#### Import:
    #import "ARCSafe_MemMgmt.h"

#### Ownership Management:
    // Each of these only produce code when compiled without ARC.
    
    // Retain an object
    myRef = as_retain(someObject);
    
    // Release an object
    as_release(someObject);
    
    // Autorelease an object
    myRef = as_autorelease(someObject);
    
    // Autorelease, but don't return a reference to the object
    as_autorelease_noref(someObject);

#### Dealloc Support:
    - (void) dealloc
    {
        // Calls [_myIvar release] when in non-ARC.
        as_release(_myIvar);
        
        // Calls [super dealloc] when in non-ARC.
        as_superdealloc();
    }

#### Property Qualifiers:
    // Note: Weak references are not supported prior to iOS 5!
    @property(as_weakprop, nonatomic, readwrite) id weakProp;
    @property(as_strongprop, nonatomic, readwrite) id strongProp;

#### Storage Qualifiers:
    // Note: Weak references are not supported prior to iOS 5!
    id as_weak weakValue;
    id as_strong strongValue;
    id as_unsafe_unretained unsafeUnretainedValue;
    id as_autoreleasing autoreleasingValue;

#### Bridging:
    CFErrorRef errorRef = CFErrorCreate(NULL, (as_bridge CFStringRef)domain, 1, (as_bridge CFDictionaryRef)userInfo);
    *error = as_autorelease((as_bridge NSError*)errorRef);

#### Autorelease Pools:
    as_autoreleasepool_start(pool_a);
    
    ...
    
    as_autoreleasepool_end(pool_a);


Full Example
------------

I've included a full example project in this repository.
See **ViewController.h** and **ViewController.m** for details.


License
-------

Copyright (c) 2011 Karl Stenerud. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall remain in place
in this source code.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
