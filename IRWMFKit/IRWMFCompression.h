//
//  IRWMFCompression.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

typedef enum {
	IRWMFCompression_BI_RGB = 0x0000,
	IRWMFCompression_BI_RLE8 = 0x0001,
	IRWMFCompression_BI_RLE4 = 0x0002,
	IRWMFCompression_BI_BITFIELDS = 0x0003,
	IRWMFCompression_BI_JPEG = 0x0004,
	IRWMFCompression_BI_PNG = 0x0005,
	IRWMFCompression_BI_CMYK = 0x000B,
	IRWMFCompression_BI_CMYKRLE8 = 0x000C,
	IRWMFCompression_BI_CMYKRLE4 = 0x000D
} IRWMFCompression;