//
//  IRWMFSaveDeviceContextRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFSaveDeviceContextRecord.h"
#import "IRWMFExportSession.h"

@implementation IRWMFSaveDeviceContextRecord

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_SAVEDC);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	CGContextSaveGState(aSession.context);

}

@end
