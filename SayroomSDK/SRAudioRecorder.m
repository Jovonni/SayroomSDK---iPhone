//
//  SRAudioRecorder.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "SRAudioRecorder.h"
#import "SRServerCalls.h"

@interface SRAudioRecorder(){
    AVAudioPlayer *audio;
    AVAudioRecorder *audioRecorder;
    NSTimer *recordingTimer;
    int timeLimitForRecording;
    int recordingtime;
}

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audio;
@property (retain, nonatomic) NSTimer *recordingTimer;

@end

@implementation SRAudioRecorder

@synthesize audioRecorder;
@synthesize audio;
@synthesize recordingTimer;

-(id)init{
    
    self = [super init];
    
    return self;
}


-(BOOL)isReadyToRecord{
    BOOL isReadyToRecord;
        if(audioRecorder.prepareToRecord){
            NSLog(@"is ready to record");
            isReadyToRecord = YES;
        }else{
            NSLog(@"is NOT ready to record");
            isReadyToRecord =  NO;
        }
    return isReadyToRecord;
}

-(void)startUpRecorderSession{
    
    ////// start recorder initiator
    
    if (![recordingTimer isValid]){
        NSLog(@"Readying recorder");
        
        
        ////////////THREAD
        dispatch_queue_t SendQueue = dispatch_queue_create("com.apt.OppQueue", 0);
        
        dispatch_async(SendQueue, ^{
        
            
            [self readyRecorder];
            
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                //main thread things
                
            });
            
        });
        
            
    }else{
        NSLog(@"Recorder/Timer running");
    }
    
    //////// end recorder initiator
    
}

-(void)readyRecorder{
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:&error];
    
    audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    
    audioRecorder.delegate = self;
    
    if (error){
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        NSLog(@"prearing to record");
        [audioRecorder prepareToRecord];
    }
}



-(void)killTheRecorder{
    [audioRecorder stop];
}

-(void)pauseTheRecorder{
    [audioRecorder pause];
}

-(void)unpauseTheRecorder{
    //must be other way to unpause recorder
    [audioRecorder record];
}

-(void)startTheRecorder{
    [audioRecorder record];
}

-(BOOL)recordAudio: (int)timeLimit{
    
    //attempt to record
    
    if(timeLimit == 10){
        timeLimitForRecording = timeLimit;
    }else if(timeLimit == 20){
        timeLimitForRecording = timeLimit;
    }else if(timeLimit == 30){
        timeLimitForRecording = timeLimit;
    }else{
        timeLimitForRecording = 10;
    }
    
    
    
    
    if([recordingTimer isValid]){
        NSLog(@"isValid and trying to record");
        [recordingTimer invalidate], recordingTimer=nil;
    }
    
    ////////////THREAD
    
    //if not recording
    if (!audioRecorder.recording && ![recordingTimer isValid]){
        //playButton.enabled = NO;
        NSLog(@"About to record");
        
        ////////////THREAD
        dispatch_queue_t SendQueue = dispatch_queue_create("com.apt.OppQueue", 0);
        
        dispatch_async(SendQueue, ^{
        
            [self startTheRecorder];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                //main thread things
                
            });
            
        });
        
        //take out setting title, set title in timer
        //[recordingButton setTitle:@"Listening" forState:UIControlStateNormal];
        
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                          target:self
                                                        selector:@selector(isRecordingAtLimit)
                                                        userInfo:nil repeats:YES
                          ];
        
    } else {
        
        //if not recording, and recording timer is valid --  is recording
        
        if([self stopTheRecording]){
            NSLog(@"From stop recording caller");
        }
        
    }
    
    
    //end attempt to record
    //
    return YES;
    
    
    
}


-(void)playAudio{
    
    
    NSError *error;
    
    NSLog(@"%@",audioRecorder.url);
    
    audio = [[AVAudioPlayer alloc]
                                initWithContentsOfURL:audioRecorder.url
                                error:&error];
    
    audio.delegate = self;
    
    
    if (error){
        NSLog(@"Error: %@",
        [error localizedDescription]);
    }
    else{
        if([audio prepareToPlay]){
            [audio play];
            NSLog(@"Done playing");
        }
    }
    
    
    
    
    
    
    
}

-(void)isRecordingAtLimit{
    
    recordingtime = audioRecorder.currentTime;
    int countdowntime = recordingtime - timeLimitForRecording;
    int realcountdowntime = countdowntime * -1;
    
    
    
     //
    
    //count, and stop at 10
    if (recordingtime<timeLimitForRecording) {
        //NSLog(@"less than");
        NSLog(@"Listening:  %i", realcountdowntime);
        
    } else if (recordingtime>=timeLimitForRecording){
        NSLog(@"Done");
        //stop recording
        [self recordAudio: timeLimitForRecording];
    }
    
}

-(float)sendRecordingTime{
    return audioRecorder.currentTime;
}


-(BOOL)stopRecordingOnImage: (int)biid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    
    
    if (!audioRecorder.recording && ![recordingTimer isValid]){
         NSLog(@"stopping recording");
    
        SRServerCalls *srsc = [[SRServerCalls alloc] init];
    
        NSString *userLocation = @"THELOCATION";
    
        [srsc userUploadAudioForImage:rmid brandImageID:biid userLocation:userLocation apikey:apik];
    
        return YES;

    }else{
        NSLog(@"stop recording on task: no");
        return NO;
    }
    
       
}


-(BOOL)stopRecordingOnTask: (int)btid reactorMemberID: (int)rmid APIKey: (NSString *)apik{
    
    if (!audioRecorder.recording && ![recordingTimer isValid]){
        
        NSLog(@"stopping recording");
    
        SRServerCalls *srsc = [[SRServerCalls alloc] init];
    
        NSString *userLocation = @"THELOCATION";
    
        [srsc userUploadAudioForTask:rmid brandTaskID:btid userLocation:userLocation apikey:apik];
    
        return YES;
        
    }else{
        NSLog(@"stop recording on task: no");
        return NO;
    }
    
    
    
}

-(BOOL)stopTheRecording{
    
    
    NSLog(@"stopped: %d", recordingtime);
    
    [self killTheRecorder];
    [recordingTimer invalidate];
    recordingTimer=nil;
    
    
    return YES;
    
}

//delegate methods for audio

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"Should have finished playing");
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"Recorder Finished Recording");
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode Error occurred");
}

@end
