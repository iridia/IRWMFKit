//
//  IRWMFSetMapModeRecord.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFRecord.h"

@interface IRWMFSetMapModeRecord : IRWMFRecord <IRWMFRecordExporting>

@property (nonatomic, readonly, assign) IRWMFMapMode mapMode;

@end
