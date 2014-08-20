//
//  SRServerCalls.h
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRServerCalls : NSObject {
    
    
    
}
-(BOOL)verifyAPI: (int)reactorMemberID withApplicationKey: (NSString *)apiKey;
-(BOOL)userUploadAudioForImage: (int)userID brandImageID: (int)biid userLocation: (NSString*)userCurrentLocation apikey:(NSString *)apikey;
-(BOOL)userUploadAudioForTask: (int)userID brandTaskID: (int)btid userLocation: (NSString*)userCurrentLocation apikey:(NSString *)apikey;

@end
