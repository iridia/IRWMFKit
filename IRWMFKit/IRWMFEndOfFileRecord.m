//
//  IRWMFEndOfFileRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFEndOfFileRecord.h"

@implementation IRWMFEndOfFileRecord

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_EOF);

}

@end
