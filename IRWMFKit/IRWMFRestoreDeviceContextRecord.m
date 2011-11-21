//
//  IRWMFRestoreDeviceContextRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFRestoreDeviceContextRecord.h"
#import "IRWMFExportSession.h"

@implementation IRWMFRestoreDeviceContextRecord

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_RESTOREDC);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	CGContextSaveGState(aSession.context);

}

@end
