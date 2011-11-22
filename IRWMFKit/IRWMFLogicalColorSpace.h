//
//  IRWMFLogicalColorSpace.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

typedef enum {
	IRWMFLogicalColorSpace_LCS_CALIBRATED_RGB = 0x00000000,
	IRWMFLogicalColorSpace_LCS_sRGB = 0x73524742,
	IRWMFLogicalColorSpace_LCS_WINDOWS_COLOR_SPACE = 0x57696E20,
	
	//	DIB Header v5
	IRWMFLogicalColorSpace_LCS_PROFILE_LINKED = 0x4C494E4B,
	IRWMFLogicalColorSpace_LCS_PROFILE_EMBEDDED = 0x4D424544	
} IRWMFLogicalColorSpace;
