/*
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "MCSubscribeKeyViewController.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MCSubscribeKeyViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *subscriberKey;

@end

@implementation MCSubscribeKeyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view, typically from a nib.
	self.subscriberKey.text = [[MarketingCloudSDK sharedInstance] sfmc_contactKey];
    
    NSString *hash =self.subscriberKey.text;
    if(hash != nil){
        NSData *hash_binary = [MCSubscribeKeyViewController dataFromHexString:hash];
        NSLog(@"hash is %@", hash);
        
        NSLog(@"hash(binary) is %@", hash_binary);
        NSString *base64EncodedString = [hash_binary base64EncodedStringWithOptions:5];
        NSLog(@"hash(base64) is %@", base64EncodedString);
    }
    
	[[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://SubscriberkeyViewLoaded" title:@"Subscriber Key View Loaded" item:nil search:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

/**
 Uses setSubscriberKey method to save the text as the Subscriber Key.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)saveSubscriberKey:(id)sender {
	[[MarketingCloudSDK sharedInstance] sfmc_setContactKey:self.subscriberKey.text];
    
    NSString *hash = self.subscriberKey.text;
    if(hash != nil){
        NSData *hash_binary = [MCSubscribeKeyViewController dataFromHexString:hash];
        NSLog(@"hash is %@", hash);
        
        NSLog(@"hash(binary) is %@", hash_binary);
        NSString *base64EncodedString = [hash_binary base64EncodedStringWithOptions:0];
        NSLog(@"hash(base64) is %@", base64EncodedString);
        [[MarketingCloudSDK sharedInstance] sfmc_setContactKey:base64EncodedString];
    }
    
	[[MarketingCloudSDK sharedInstance] sfmc_trackPageViewWithURL:@"data://SubscriberKeySet" title:@"User Set Subscriber key" item:nil search:nil];
	
}

/**
 Uses getSubscriberKey method to get the Subscriber Key and sets it in the UITextField.
 
 @param sender An ID of a component of the user interface.
 
 @return An action for the method to display in the view.
 */
- (IBAction)reloadSubscriberKey:(id)sender {
	self.subscriberKey.text = [[MarketingCloudSDK sharedInstance] sfmc_contactKey];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

+ (NSData *) dataFromHexString:(NSString*)hexString
{
    int len = [hexString length] - 1;
    char *chars = (char *) [hexString UTF8String];
    //    int i = 0, len = 127;
    NSLog(@"char is %s", chars);
    int i = 0;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i];
        i = i + 1;
        byteChars[1] = chars[i];
        i = i + 1;
        
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

@end
