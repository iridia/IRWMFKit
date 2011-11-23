//
//  IRWMFKitTest.h
//  IRWMFKitTest
//
//  Created by Evadne Wu on 11/19/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class IRWMFDocument;
@interface IRWMFKitTest : SenTestCase

- (IRWMFDocument *) newTestDocument NS_RETURNS_RETAINED;

@end
