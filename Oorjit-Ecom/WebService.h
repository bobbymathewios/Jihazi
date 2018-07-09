//
//  WebService.h
//  Drzone
//
//  Created by KG Sajith on 01/11/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSON.h"
#import "JSONKit.h"
@protocol passDataAfterParsing <NSObject>

-(void)finishedParsingDictionary:(NSDictionary *)dictionary;
-(void)failServiceMSg;
//-(void)fail:(id)value;
@end
@interface WebService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLSessionDelegate>
{
    NSMutableData *responseData;
}
@property(nonatomic,strong)id<passDataAfterParsing>PDA;

-(void)getDataFromService:(NSURLRequest *)URL;
- (void) getUrlReqForPostingBaseUrl:(NSString*)Url andTextData:(NSMutableDictionary*)textDict;
- (void) getUrlReqForUpdatingProfileBaseUrl:(NSString*)Url andTextData:(NSMutableDictionary*)textDict andImageData:(NSMutableDictionary*)imageDict;
@end
