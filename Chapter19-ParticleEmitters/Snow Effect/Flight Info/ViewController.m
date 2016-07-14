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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self.summary addSubview:self.summaryIcon];
    self.summaryIcon.center = CGPointMake(self.summaryIcon.center.x, self.summary.frame.size.height / 2);
    
    
    [self changeFlightDataTo:_londonToParis animated:NO];
    
    CGRect rect = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 50.0);
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = rect;
    [self.view.layer addSublayer:emitter];
    
    emitter.emitterShape = kCAEmitterLayerRectangle;
    emitter.emitterPosition = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    emitter.emitterSize = rect.size;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake"].CGImage);
    emitterCell.birthRate = 150;
    emitterCell.lifetime = 3.5;
    
    emitterCell.yAcceleration = 70.0;
    emitterCell.xAcceleration = 10.0;
    emitterCell.velocity = 20.0;
    emitterCell.emissionLongitude = (-M_PI);
    emitterCell.velocityRange = 200.0;
    emitterCell.emissionRange = (M_PI_2);
    emitterCell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
    emitterCell.redRange = 0.1;
    emitterCell.greenRange = 0.1;
    emitterCell.blueRange = 0.1;
    emitterCell.scale = 0.8;
    emitterCell.scaleRange = 0.8;
    emitterCell.scaleSpeed = -0.15;
    emitterCell.alphaRange = 0.75;
    emitterCell.alphaSpeed = -0.15;
    emitterCell.lifetimeRange = 1.0;
    
    //cell #2
    CAEmitterCell *cell2 = [CAEmitterCell emitterCell];
    cell2.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake2.png"].CGImage);
    cell2.birthRate = 50;
    cell2.lifetime = 2.5;
    cell2.lifetimeRange = 1.0;
    cell2.yAcceleration = 50;
    cell2.xAcceleration = 50;
    cell2.velocity = 80;
    cell2.emissionLongitude = (M_PI);
    cell2.velocityRange = 20;
    cell2.emissionRange = (M_PI_4);
    cell2.scale = 0.8;
    cell2.scaleRange = 0.2;
    cell2.scaleSpeed = -0.1;
    cell2.alphaRange = 0.35;
    cell2.alphaSpeed = -0.15;
    cell2.spin = (M_PI);
    cell2.spinRange = (M_PI);
    
    //cell #3;
    CAEmitterCell *cell3 = [CAEmitterCell emitterCell];
    cell3.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake3"].CGImage);
    cell3.birthRate = 20;
    cell3.lifetime = 7.5;
    cell3.lifetimeRange = 1.0;
    cell3.yAcceleration = 20;
    cell3.xAcceleration = 10;
    cell3.velocity = 40;
    cell3.emissionLongitude = (M_PI);
    cell3.velocityRange = 50;
    cell3.emissionRange = (M_PI_4);
    cell3.scale = 0.8;
    cell3.scaleRange = 0.2;
    cell3.scaleSpeed = -0.05;
    cell3.alphaRange = 0.5;
    cell3.alphaSpeed = -0.05;
    emitter.emitterCells = @[emitterCell,cell2,cell3];
    
}

- (void)changeFlightDataTo:(FlightData *)data animated:(BOOL)animated {
    
    self.summary.text = data.summary;
    
    self.flightNr.text = data.flightNr;
    self.gateNr.text = data.gateNr;
    
    self.departingFrom.text = data.departingFrom;
    self.arrivingTo.text = data.arrivingTo;
    
    self.flightStatus.text = data.flightStatus;
    self.bgImageView.image = [UIImage imageNamed:data.weatherImageName];
    
    
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
