//
//  ViewController.m
//  Iris
//
//  Created by dudawei on 16/6/24.
//  Copyright © 2016年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "MicMonitor.h"
#import "Assistant.h"

static const CGFloat dotLength = 6.0;
static const CGFloat dotOffset = 8.0;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;
@property (nonatomic, strong) MicMonitor *monitor;
@property (nonatomic, strong) Assistant *assistant;

@property (nonatomic, strong) CAReplicatorLayer *replicator;
@property (nonatomic, strong) CALayer *dot;
@property (nonatomic, assign) CGFloat lastTransformScale;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.meterLabel.numberOfLines = 0;
    self.monitor = [[MicMonitor alloc] init];
    self.assistant = [[Assistant alloc] init];
    
    self.lastTransformScale = 0.0;
    
    self.replicator = [CAReplicatorLayer layer];
    self.replicator.frame = self.view.bounds;
    [self.view.layer addSublayer:self.replicator];
    
    self.dot = [CALayer layer];
    self.dot.frame = CGRectMake(self.replicator.frame.size.width - dotLength, self.replicator.position.y, dotLength, dotLength);
    self.dot.backgroundColor = [UIColor lightGrayColor].CGColor;
    self.dot.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    self.dot.borderWidth = 0.5;
    self.dot.cornerRadius = 1.5;
    
    [self.replicator addSublayer:self.dot];
    
    self.replicator.instanceCount = (int)(self.view.frame.size.width / dotOffset);
    self.replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0.0, 0.0);
    
    self.replicator.instanceDelay = 0.02;
    
}

- (IBAction)actionStartMonitoring:(UIButton *)sender {
    
    self.dot.backgroundColor = [UIColor greenColor].CGColor;
    [self.monitor startMonitoringWithHandler:^(NSNumber *count) {
        self.meterLabel.text = [NSString stringWithFormat:@"%.2f db",[count floatValue]];
        CGFloat scaleFactor = MAX(0.2, [count floatValue] + 50)/2;
        
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        scale.fromValue = @(self.lastTransformScale);
        scale.toValue = @(scaleFactor);
        scale.duration = 1.0;
        scale.removedOnCompletion = NO;
        scale.fillMode = kCAFillModeForwards;
        [self.dot addAnimation:scale forKey:nil];
        
        self.lastTransformScale = scaleFactor;
    }];
}
- (IBAction)actionEndMonitoring:(UIButton *)sender {
    
    
    [self.monitor stopMonitoring];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scale.fromValue = @(self.lastTransformScale);
//    scale.toValue = @(0.2);
    scale.toValue = @(1.0);
    scale.duration = 0.2;
    scale.removedOnCompletion = NO;
    scale.fillMode = kCAFillModeForwards;
    [self.dot addAnimation:scale forKey:nil];
    self.dot.backgroundColor = [UIColor magentaColor].CGColor;
    
    CABasicAnimation *tint = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    tint.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    tint.toValue = (__bridge id _Nullable)([UIColor magentaColor].CGColor);
    tint.duration = 1.2;
    tint.fillMode = kCAFillModeForwards;
    [self.dot addAnimation:tint forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startSpeaking];
    });
}

- (void)startSpeaking{
    
    NSLog(@"speak back");
    
    self.meterLabel.text = [self.assistant randomAnswer];
    
    __weak typeof(self) wself = self;
    [self.assistant speark:self.meterLabel.text completion:^{
        [wself endSpeaking];
    }];
    self.speakButton.hidden = YES;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 15, 1.0)];
    scale.duration = 0.33;
    scale.repeatCount = MAXFLOAT;
    scale.autoreverses = YES;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.dot addAnimation:scale forKey:@"dotScale"];
    
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @(1.0);
    fade.toValue = @(0.2);
    fade.duration = 0.33;
    fade.beginTime = CACurrentMediaTime() + 0.33;
    fade.repeatCount = MAXFLOAT;
    fade.autoreverses = YES;
    fade.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.dot addAnimation:fade forKey:@"dotOpacity"];
    
    CABasicAnimation *tint = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    tint.fromValue = (__bridge id _Nullable)([UIColor magentaColor].CGColor);
    tint.toValue = (__bridge id _Nullable)([UIColor cyanColor].CGColor);
    tint.duration = 0.66;
    tint.beginTime = CACurrentMediaTime() + 0.28;
    tint.fillMode = kCAFillModeForwards;
    tint.repeatCount = MAXFLOAT;
    tint.autoreverses = YES;
    tint.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.dot addAnimation:tint forKey:@"dotColor"];
    
    CABasicAnimation *initialRotation = [CABasicAnimation animationWithKeyPath:@"instanceTransform.rotation"];
    initialRotation.fromValue = @(0.0);
    initialRotation.toValue = @(0.01);
    initialRotation.duration = 0.33;
    initialRotation.removedOnCompletion = NO;
    initialRotation.fillMode = kCAFillModeForwards;
    initialRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.replicator addAnimation:initialRotation forKey:@"initialRotation"];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"instanceTransform.rotation"];
    rotation.fromValue = @(0.01);
    rotation.toValue = @(-0.01);
    rotation.duration = 0.99;
    rotation.beginTime = CACurrentMediaTime() + 0.33;
    rotation.repeatCount = MAXFLOAT;
    rotation.autoreverses = YES;
    rotation.fillMode = kCAFillModeForwards;
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.replicator addAnimation:initialRotation forKey:@"replicatorRotation"];
 
}

- (void)endSpeaking{
   
    [self.replicator removeAllAnimations];
    self.meterLabel.text = nil;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.duration = 0.33;
    scale.removedOnCompletion = NO;
    scale.fillMode = kCAFillModeForwards;
    [self.dot addAnimation:scale forKey:nil];
    
    [self.dot removeAnimationForKey:@"dotColor"];
    [self.dot removeAnimationForKey:@"dotOpacity"];
    self.dot.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    self.speakButton.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
