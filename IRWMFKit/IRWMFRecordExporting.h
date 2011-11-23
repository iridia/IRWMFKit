//
//  IRWMFRecordExporting.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRWMFExportSession;
@protocol IRWMFRecordExporting <NSObject>

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession;

@end
