//
//  GVFController.m
//  GVFixer
//
//  Created by David Ryskalczyk on 2014/08/23.
//  Copyright 2014 David Ryskalczyk All rights reserved.
//	GVFixer is released under the MIT License.
//  Thanks to cvz for providing a nice template
//  in the form of ColorfulSidebar!
//	http://opensource.org/licenses/mit-license.php
//

#import "GVFController.h"
#import <objc/objc-class.h>


void GVFSwizzleInstanceMethod (Class cls, SEL old, SEL new) {
	Method mold = class_getInstanceMethod(cls, old);
	Method mnew = class_getInstanceMethod(cls, new);
	if (mold && mnew) {
		if (class_addMethod(cls, old, method_getImplementation(mold), method_getTypeEncoding(mold))) {
			mold = class_getInstanceMethod(cls, old);
		}
		if (class_addMethod(cls, new, method_getImplementation(mnew), method_getTypeEncoding(mnew))) {
			mnew = class_getInstanceMethod(cls, new);
		}
		method_exchangeImplementations(mold, mnew);
	}
}


@implementation NSObject (GVFixer)

- (void)GVF_accountInfoFetcher:fetcher finishedWithData:data error:err
{
    NSString *sdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];


    NSRange start = [sdata rangeOfString:@"var _gcData = "];
    NSRange end = [sdata rangeOfString:@"};" options:nil range:NSMakeRange(start.location, [sdata length]-(start.location))];

    sdata = [sdata stringByReplacingOccurrencesOfString:@"'" withString:@"\"" options:nil range:NSMakeRange(start.location, end.location-start.location)];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(,)(\\s*\\})" options:nil error:&error];

    if (error)
    {
        NSLog(@"Couldn't create regex with given string and options");
    }

    sdata = [regex stringByReplacingMatchesInString:sdata options:nil range:NSMakeRange(start.location, end.location-start.location) withTemplate:@"$2"];

    
    NSData *newData = [sdata dataUsingEncoding:NSUTF8StringEncoding];

	[self GVF_accountInfoFetcher:fetcher finishedWithData:newData error:err];
}

@end



@implementation GVFController

+ (void)load
{
    Class cls;
    SEL old, new;
    cls = NSClassFromString(@"GoogleVoiceLoginInterface");
    old = @selector(accountInfoFetcher:finishedWithData:error:);
    new = @selector(GVF_accountInfoFetcher:finishedWithData:error:);
    GVFSwizzleInstanceMethod(cls, old, new);
			
}
@end
