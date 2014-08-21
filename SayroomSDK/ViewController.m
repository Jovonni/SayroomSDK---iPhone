//
//  ViewController.m
//  SayroomSDK
//
//  Created by Jovonni Pharr on 8/16/14.
//  Copyright (c) 2014 Clear I Media. All rights reserved.
//

#import "ViewController.h"
#import "SayroomSDK.h"

@interface ViewController (){
    NSString * apikey;
    int reactorMemberID;
    SayroomSDK *srsdk;
}



@end

@implementation ViewController

-(IBAction)recordAudio:(id)sender{
    
    [srsdk recordAudio];
}

-(IBAction)stopRecordingOnImage:(id)sender{
    
    
    [srsdk stopRecordingOnImage:1];
    
}

-(IBAction)stopRecordingOnTask:(id)sender{
    
    [srsdk stopRecordingOnTask:1];
    
}

-(IBAction)playAudio:(id)sender{
    
    [srsdk playCurrentAudioRecording];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //apikey = @"bi4WZa1TXqRv75sJXKMjLY6JarnFDwZpQ1WqodwLkSG2rdKmG8";
    apikey = @"3r9gyBK3hurUQx82OwMSsjm4";
    reactorMemberID = 1;
    
    srsdk = [[SayroomSDK alloc] initWithApplicationKey:reactorMemberID APIKey:apikey];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
