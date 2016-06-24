//
//  Assistant.m
//  Iris
//
//  Created by dudawei on 16/6/24.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "Assistant.h"
#import <AVFoundation/AVFoundation.h>

@interface Assistant ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, strong) completion completionBlock;
@property (nonatomic, strong) AVSpeechSynthesizer *synth;

@end

@implementation Assistant

- (NSArray *)answers{
    if (!_answers) {
        
        _answers = @[@"OK from now on I'll call you 'my little princess'. I sent your new name to all your contacts as well",
                   @"Can't find any local business around you for search term 'cheap booze'",
                   @"Looks like you are leaving the house - don't forget you're living in a post apocalyptic zombie world",
                   @"Making a wake up reminder for 3:00 AM. Don't wake me up...",
                   @"Here is the list of the 20 closest 'raging football fans' around you"];
    }
    
    return _answers;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.synth = [[AVSpeechSynthesizer alloc] init];
        self.synth.delegate = self;
    }
    
    return self;
}

- (NSString *)randomAnswer {
    NSInteger index = (NSInteger)arc4random_uniform((uint32_t)_answers.count);
    return self.answers[index];
}

- (void)speark:(NSString *)phrase completion:(completion)completion{
    _completionBlock = completion;
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:phrase];
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
    utterance.volume = 1.0;
    [_synth speakUtterance:utterance];
}

#pragma mark - speech synth methods
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    if (_completionBlock) {
        _completionBlock();
    }
}

@end
