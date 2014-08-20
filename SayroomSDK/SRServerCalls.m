//
//  SRServerCalls.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "SRServerCalls.h"


@interface SRServerCalls(){
    
    
    
}



@end

@implementation SRServerCalls



-(BOOL)verifyAPI: (int)reactorMemberID withApplicationKey: (NSString *)apiKey{
    
        //this gets called from sayroomSDK, upon
    
        NSLog(@"Verifying API");
    
    BOOL verficationResult = [self verifyUserAPIKey:reactorMemberID apikey:apiKey];
    
        if(verficationResult){
        
            NSLog(@"verified: true");
            
            return YES;
        
        }else{
        
            NSLog(@"verified: False");
            
            return NO;
        
        }
    
    NSLog(@"verified: Last Log");
    
    return YES;
    
}

-(BOOL)verifyUserAPIKey:(int)reactorMemberID apikey: (NSString *)apiKey{
    
    //call server and get response
    
    NSLog(@"Verifying: Server Call");
    
    ///end call server and get response
    
    
    /////////////server call
    ///////////EDIT
    
    NSString *verifyString = [NSString stringWithFormat:@"http://api.sayroom.com/v1/sayroomModel/userCheckAPIKey?api_key=%@&rmid=%i", apiKey, reactorMemberID];
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:verifyString]];
    
    //original
    NSError* error;
    //place json into dictionary
    NSDictionary *fulljson = [NSJSONSerialization
                              JSONObjectWithData:data //1
                              
                              options:kNilOptions
                              error:&error];
    
    NSLog(@"json: %@", fulljson);
    
    /////////////end server call
    
    return YES;
    
}

-(BOOL)userUploadAudioForImage: (int)userID brandImageID: (int)biid userLocation: (NSString*)userCurrentLocation apikey:apik{
    
    NSLog(@"Called user upload for image in SRServerCalls");
    
    
    /////////////////////////////////////////////////////////////////send
    
    
    dispatch_queue_t SendQueue = dispatch_queue_create("com.apt.OppQueue", 0);
	
	dispatch_async(SendQueue, ^{
        
        //try to send audio
        
        
        
        //////////////////////////////////////
        
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        
        NSString *filePath = [docsDir
                              stringByAppendingPathComponent:@"sound.caf"];
        
        
        
        //get file path
        NSLog(@"the file path: %@", filePath);
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        NSLog(@"BOOL = %d", (int)fileExists);
        //end get file path


        
        //4sq venue id for server reference
        
        //end set parameters to be sent
        
        if(fileExists==1){
            
            //NSString *file2 = [[NSBundle mainBundle] pathForResource:filePath ofType:@""];
            //NSString *file2 = [[NSBundle mainBundle] pathForResource:filePath ofType:@"caf"];
            
            NSData *file1Data = [[NSData alloc] initWithContentsOfFile:filePath];
            NSString *urlString = [NSString stringWithFormat:@"http://api.sayroom.com/v1/sayroomModel/recordUploadImages/%i/%i/loc?api_key=%@", userID, biid, apik];
            
            NSLog(@"url: %@", urlString);
            
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file_contents\"; filename=\"sound.caf\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:file1Data]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"Return String= %@",returnString);
            NSLog(@"Audio Sent Successfully");
            
            returnString = nil;
            
            
        } else {
            NSLog(@"File is empty");
        }
        
        
        //end try to send audio
        
		
		dispatch_async(dispatch_get_main_queue(), ^ {
			//main thread things
            
		});
		
	});
	   
    
    
    /////////////////////////////////////////////////////////////////END send
    
    
    NSLog(@"Done with thread to send");
    
    return YES;
    
    
}

-(BOOL)userUploadAudioForTask: (int)userID brandTaskID: (int)btid userLocation: (NSString*)userCurrentLocation apikey:apik{
    
    
    /////////////////////////////////////////////////////////////////send
    
    
    dispatch_queue_t SendQueue = dispatch_queue_create("com.apt.OppQueue", 0);
	
	dispatch_async(SendQueue, ^{
        
        //try to send audio
        
        
        
        //////////////////////////////////////
        
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        
        NSString *filePath = [docsDir
                              stringByAppendingPathComponent:@"sound.caf"];
        
        
        
        //get file path
        NSLog(@"the file path: %@", filePath);
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        NSLog(@"BOOL = %d", (int)fileExists);
        //end get file path
        
        
        
        //4sq venue id for server reference
        
        //end set parameters to be sent
        
        if(fileExists==1){
            
            //NSString *file2 = [[NSBundle mainBundle] pathForResource:filePath ofType:@""];
            //NSString *file2 = [[NSBundle mainBundle] pathForResource:filePath ofType:@"caf"];
            
            NSData *file1Data = [[NSData alloc] initWithContentsOfFile:filePath];
            NSString *urlString = [NSString stringWithFormat:@"http://api.sayroom.com/v1/sayroomModel/recordUploadTasks/%i/%i/loc?api_key=%@", userID, btid, apik];
            
            NSLog(@"url: %@", urlString);
            
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file_contents\"; filename=\"sound.caf\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:file1Data]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog(@"Return String= %@",returnString);
            NSLog(@"Audio Sent Successfully");
            
            returnString = nil;
            
            
        } else {
            NSLog(@"File is empty");
        }
        
        
        //end try to send audio
        
		
		dispatch_async(dispatch_get_main_queue(), ^ {
			//main thread things
            
		});
		
	});
    
    
    
    /////////////////////////////////////////////////////////////////END send
    
    
    return YES;
    
}




@end
