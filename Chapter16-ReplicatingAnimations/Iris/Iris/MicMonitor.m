//
//  MicMonitor.m
//  Iris
//
//  Created by dudawei on 16/6/24.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "MicMonitor.h"
#import <AVFoundation/AVFoundation.h>


@implementation MicMonitor
{
    AVAudioRecorder *_recorder;
    NSTimer *_timer;
    levelsHander _levelsHander;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null" isDirectory:YES];
        NSDictionary *settings = @{
                                   AVSampleRateKey:@44100.0,
                                   AVNumberOfChannelsKey:@1,
                                   AVFormatIDKey:[NSNumber numberWithUnsignedInt:kAudioFormatAppleLossless],
                                   AVEncoderAudioQualityKey: [NSNumber numberWithInteger: AVAudioQualityMin]
                                   };
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if (audioSession.recordPermission != AVAudioSessionRecordPermissionGranted) {
            [audioSession requestRecordPermission:^(BOOL granted) {
                NSLog(@"microphone permission: %d",granted);
            }];
        }
        
        NSError *error;
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        
        if (error) {
            NSLog(@"Couldn't initialize the mic input");
        }
        
        if (_recorder) {
        
            [_recorder prepareToRecord];
            _recorder.meteringEnabled = YES;
        }
    }
    
    return self;
}

- (void)startMonitoringWithHandler:(levelsHander)handler{
    _levelsHander = handler;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(handleMicLevel:) userInfo:nil repeats:YES];
    [_recorder record];
}

- (void)handleMicLevel:(NSTimer *)timer {
    [_recorder updateMeters];
    if (_levelsHander) {
        _levelsHander(@([_recorder averagePowerForChannel:0]));
    }
    
}

- (void)stopMonitoring{
    _levelsHander = nil;
    [_timer invalidate];
    [_recorder stop];
}

- (void)dealloc{
    [self stopMonitoring];
}

@end
