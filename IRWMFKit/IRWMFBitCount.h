//
//  IRWMFBitCount.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

typedef enum {

	IRWMFCompressedImageBitCount = 0x0000,
	IRWMFMonochromeBitCount = 0x0001,
	IRWMF16ColorsBitCount = 0x0004,
	IRWMF256ColorsBitCount = 0x0008,
	IRWMF65536ColorsBitCount = 0x0010,
	IRWMF16MillionPaletteColorsBitCount = 0x0018,
	IRWMF16MillionColorsBitCount = 0x0020,
	
	IRWMFBitCount_BI_BITCOUNT_0 = IRWMFCompressedImageBitCount,
	IRWMFBitCount_BI_BITCOUNT_1 = IRWMFMonochromeBitCount,
	IRWMFBitCount_BI_BITCOUNT_2 = IRWMF16ColorsBitCount,
	IRWMFBitCount_BI_BITCOUNT_3 = IRWMF256ColorsBitCount,
	IRWMFBitCount_BI_BITCOUNT_4 = IRWMF65536ColorsBitCount,
	IRWMFBitCount_BI_BITCOUNT_5 = IRWMF16MillionPaletteColorsBitCount,
	IRWMFBitCount_BI_BITCOUNT_6 = IRWMF16MillionColorsBitCount

} IRWMFBitCount;
