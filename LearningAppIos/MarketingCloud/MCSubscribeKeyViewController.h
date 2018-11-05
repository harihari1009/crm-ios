/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import <UIKit/UIKit.h>

@interface MCSubscribeKeyViewController : UIViewController

- (id)initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options NS_AVAILABLE(10_9, 7_0);

+ (NSData *) dataFromHexString:(NSString*)hexString;

@end

@interface NSString (NSStringHexToBytes)
-(NSData*) hexToBytes ;
@end
