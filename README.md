# IRWMFKit!

WMF ➡ CGImageRef, App Store compatible.  Evadne Wu at Iridia Productions, 2011.


### Why?

Because **wv** and **UniConverter** are both GPL/LGPL, and GPL/LGPL is evil (“incompatible with the App Store”).


### How?

	NSBundle *ownBundle = [NSBundle bundleForClass:[self class]];
	NSString *wmfPath = [ownBundle pathForResource:@"Image" ofType:@"wmf"];
	NSData *wmfData = [NSData dataWithContentsOfMappedFile:wmfPath];
	
	IRWMFDocument *document = [IRWMFDocument documentWithData:wmfData];
	CGImageRef fullResolutionImage = [document newFullResolutionImage];
	
	UIImage *image = [UIImage imageWithCGImage:fullResolutionImage];
	
	if (fullResolutionImage)
		CFRelease(fullResolutionImage);
	
	return image;

* * *

### Licensing & Disclaimer

Consider this project work in progress, and if you use it in production, it is licensed under the MIT license.  Please use attribution “IRWMFKit © 2011–, Evadne Wu / Iridia Productions” in the final product.

Code is not tested in all cases — who knows what might be lurking in that WMF, as with all stuff Microsoft — but test cases in the project should execute without failing.  There might be bugs or WMF enums that were not handled.  IRWMFKit is tiny and only works for included test cases, which is a wrapped bitmap extracted from a Word document.
