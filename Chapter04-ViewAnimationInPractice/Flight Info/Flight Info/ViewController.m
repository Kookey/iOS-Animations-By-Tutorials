//
//  ViewController.m
//  Flight Info
//
//  Created by dudw on 16/5/22.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "FlightData.h"
#import "SnowView.h"
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, AnimationDirection) {
    Positive = 1,
    Negative = -1
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *summaryIcon;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *flightNr;
@property (weak, nonatomic) IBOutlet UILabel *gateNr;
@property (weak, nonatomic) IBOutlet UILabel *departingFrom;
@property (weak, nonatomic) IBOutlet UILabel *arrivingTo;
@property (weak, nonatomic) IBOutlet UIImageView *planImage;
@property (weak, nonatomic) IBOutlet UILabel *flightStatus;
@property (weak, nonatomic) IBOutlet UIImageView *statusBanner;
@end



@implementation ViewController{
    FlightData *_londonToParis;
    FlightData *_parisToRome;
    SnowView *_snowView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self.summary addSubview:self.summaryIcon];
    self.summaryIcon.center = CGPointMake(self.summaryIcon.center.x, self.summary.frame.size.height / 2);
    
    
    _snowView = [[SnowView alloc] initWithFrame:CGRectMake(-150, -100, 300, 50)];
    UIView *snowClipView = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 50)];
    snowClipView.clipsToBounds = YES;
    [snowClipView addSubview:_snowView];
    [self.view addSubview:snowClipView];
    
    [self changeFlightDataTo:_londonToParis animated:NO];
    
}

- (void)changeFlightDataTo:(FlightData *)data animated:(BOOL)animated {
    
    self.summary.text = data.summary;
    
    if (animated) {
        
        [self fadeImageView:self.bgImageView toImage:[UIImage imageNamed:data.weatherImageName] showEffects:data.showWeatherEffects];
        
        AnimationDirection direction = data.isTakingOff ? Positive : Negative;
        [self cubeTransitionLabel:self.flightNr text:data.flightNr direction:direction];
        [self cubeTransitionLabel:self.gateNr text:data.gateNr direction:direction];
        
        CGPoint offsetDeparting = CGPointMake(direction * 80, 0.0);
        [self moveLabel:self.departingFrom text:data.departingFrom offset:offsetDeparting];
        
        CGPoint offsetArriving = CGPointMake(0.0, direction * 50);
        [self moveLabel:self.arrivingTo text:data.arrivingTo offset:offsetArriving];
        
        [self cubeTransitionLabel:self.flightStatus text:data.flightStatus direction:direction];
        
        
    } else {
        self.bgImageView.image = [UIImage imageNamed:data.weatherImageName];
        _snowView.hidden = !data.showWeatherEffects;
        
        self.flightNr.text = data.flightNr;
        self.gateNr.text = data.gateNr;
        
        self.departingFrom.text = data.departingFrom;
        self.arrivingTo.text = data.arrivingTo;
        
        self.flightStatus.text = data.flightStatus;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self changeFlightDataTo:data.isTakingOff ? _parisToRome : _londonToParis animated:YES];
    });
}


- (void)fadeImageView:(UIImageView *)imageView toImage:(UIImage *)toImage showEffects:(BOOL)showEffects{
    [UIView transitionWithView:imageView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imageView.image = toImage;
    } completion:nil];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _snowView.alpha = showEffects ? 1.0 : 0.0;
    } completion:nil];
}

- (void)cubeTransitionLabel:(UILabel *)label text:(NSString *)text direction:(AnimationDirection)direction {
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = label.backgroundColor;
    
    CGFloat auxlabelOffset = direction * label.frame.size.height / 2.0;
    auxLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, auxlabelOffset));
    
    [label.superview addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, -auxlabelOffset));
    } completion:^(BOOL finished) {
        label.text = text;
        label.transform = CGAffineTransformIdentity;
        
        [auxLabel removeFromSuperview];
    }];
}

- (void)moveLabel:(UILabel *)label text:(NSString *)text offset:(CGPoint)offset {
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = label.backgroundColor;
    
    auxLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
    auxLabel.alpha = 0.0;
    [self.view addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        label.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
        label.alpha = 0.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        auxLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [auxLabel removeFromSuperview];
        
        label.text = text;
        label.alpha = 1.0;
        label.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)initData {
    _londonToParis                    = [[FlightData alloc] init];
    _londonToParis.summary            = @"01 Apr 2015 09:42";
    _londonToParis.flightNr           = @"ZY 2014";
    _londonToParis.gateNr             = @"T1 A33";
    _londonToParis.departingFrom      = @"LGW";
    _londonToParis.arrivingTo         = @"CDG";
    _londonToParis.weatherImageName   = @"bg-snowy";
    _londonToParis.showWeatherEffects = YES;
    _londonToParis.isTakingOff        = YES;
    _londonToParis.flightStatus       = @"Boarding";
    
    
    _parisToRome = [[FlightData alloc] init];
    _parisToRome.summary = @"01 Apr 2015 17:05";
    _parisToRome.flightNr = @"AE 1107";
    _parisToRome.gateNr = @"045";
    _parisToRome.departingFrom = @"CDG";
    _parisToRome.arrivingTo = @"FCO";
    _parisToRome.weatherImageName = @"bg-sunny";
    _parisToRome.showWeatherEffects = NO;
    _parisToRome.isTakingOff = NO;
    _parisToRome.flightStatus = @"Delayed";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
