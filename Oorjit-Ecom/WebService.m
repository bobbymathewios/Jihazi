////
//  WebService.m
//  Drzone
//
//  Created by KG Sajith on 01/11/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "WebService.h"
#import "Loading.h"
#import "AppDelegate.h"

@implementation WebService
{
    AppDelegate *app;
}
-(void)getDataFromService:(NSURLRequest *)URL
{
    //responseData=[[NSMutableData alloc]init];
   
                                           
        // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:URL delegate:self];
    NSLog(@"%@",conn);
    
}
- (void) getUrlReqForPostingBaseUrl:(NSString*)Url andTextData:(NSMutableDictionary*)textDict
{
    app=(AppDelegate *)[UIApplication  sharedApplication].delegate;
    NSLog(@"%@",Url);
    NSLog(@"%@",textDict);
if (app.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
        //    [MY_APP_DELEGATE.postParameter removeAllObjects];
        //    [MY_APP_DELEGATE.postParameter addEntriesFromDictionary:textDict];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        for (id key in textDict) {
            
            //        NSLog(@"%@ = %@",key,[textDict objectForKey:key]);
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithString:[textDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
        
        
        
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // set request body
        [request setHTTPBody:body];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!theConnection) {
        
        // Release the receivedData object.
        responseData = nil;
        NSLog(@"%@",@"Connection lost please try again!");
        
        // Inform the user that the connection failed.
    }

        
}
- (void) getUrlReqForUpdatingProfileBaseUrl:(NSString*)Url andTextData:(NSMutableDictionary*)textDict andImageData:(NSMutableDictionary*)imageDict
{
    NSLog(@"%@-%@-%@",Url,textDict,imageDict);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    if (app.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    for (id key in imageDict) {
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"picture.jpg\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:UIImageJPEGRepresentation([imageDict objectForKey:key], 90)]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    for (id key in textDict) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[textDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!theConnection) {
        
        // Release the receivedData object.
        responseData = nil;
        
        // Inform the user that the connection failed.
    }


}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSDictionary* results=[[NSDictionary alloc]init];
    NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Your json is****%@",jsonString);
    results = [jsonString mutableObjectFromJSONString];
    [self.PDA finishedParsingDictionary:results];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    id err=error;
    
    NSLog(@"%@",err);
  //  [self.PDA fail:err];
  [self.PDA failServiceMSg];
    
  //  [Loading dismiss];
}
@end
