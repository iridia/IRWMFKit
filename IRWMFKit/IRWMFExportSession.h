//
//  IRWMFExportSession.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRWMFExportSession : NSObject

@property (nonatomic, readwrite, assign) CGContextRef context;	//	if not nil, released on -dealloc
@property (nonatomic, readwrite, assign) CGRect contentRect;	//	X / Y / Width / Height in arbitrary units represented as points in CG

@end
