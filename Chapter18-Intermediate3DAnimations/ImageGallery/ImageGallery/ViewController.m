//
//  ViewController.m
//  ImageGallery
//
//  Created by dudw on 16/6/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewCard.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *images;//of ImageViewCard 's
@end

@implementation ViewController

#pragma mark - lazy loading
- (NSArray *)images{
    if (!_images) {
        ImageViewCard *katia = [[ImageViewCard alloc] initWithImageName:@"Hurricane_Katia.jpg" title:@"Hurricane Katia"];
        ImageViewCard *Douglas = [[ImageViewCard alloc] initWithImageName:@"Hurricane_Douglas.jpg" title:@"Hurricane Douglas"];
        ImageViewCard *Norbert = [[ImageViewCard alloc] initWithImageName:@"Hurricane_Norbert.jpg" title:@"Hurricane Norbert"];
        ImageViewCard *Irene = [[ImageViewCard alloc] initWithImageName:@"Hurricane_Irene.jpg" title:@"Hurricane Irene"];
        _images = @[katia,Douglas,Norbert,Irene];
    }
    
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"info" style:UIBarButtonItemStyleDone target:self action:@selector(info)];
}

- (void)info {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Info" message:@"Public Domain images by NASA" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    for (ImageViewCard *image in self.images) {
        image.layer.anchorPoint = CGPointMake(0.5, 0.0);
        image.frame = self.view.bounds;
        
        __weak typeof(self) wself = self;
        __block ImageViewCard *img = image;
        image.didSelect = ^{
            
            [wself selectImage:img];
        };
        [self.view addSubview:image];
    }
    
    self.navigationItem.title = [self.images.lastObject title];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/250.0;
    self.view.layer.sublayerTransform = perspective;
    
}

- (void)selectImage:(ImageViewCard *)selectedImage{
    
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[ImageViewCard class]]) {
            if (subview == selectedImage) {
                
                [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    subview.layer.transform = CATransform3DIdentity;
                } completion:^(BOOL finished) {
                    [self.view bringSubviewToFront:subview];
                }];
                
            } else {
                
                [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    subview.alpha = 0.0;
                } completion:^(BOOL finished) {
                    subview.alpha = 1.0;
                    subview.layer.transform = CATransform3DIdentity;
                }];
            }
        }
    }
    
    self.navigationItem.title = selectedImage.title;
}

- (IBAction)toggleGallery:(UIBarButtonItem *)sender {
    
    CGFloat imageYOffset = 50.0;
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[ImageViewCard class]]) {
            
            CATransform3D imageTransform = CATransform3DIdentity;
            imageTransform = CATransform3DTranslate(imageTransform, 0.0, imageYOffset, 0.0);
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.6, 1.0);
            imageTransform = CATransform3DRotate(imageTransform, (M_PI_4 / 2), -1.0, 0.0, 00);
            
            //animation
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue = [NSValue valueWithCATransform3D:subview.layer.transform];
            animation.toValue = [NSValue valueWithCATransform3D:imageTransform];
            animation.duration = 0.33;
            
            [subview.layer addAnimation:animation forKey:nil];
            
            
            subview.layer.transform = imageTransform;
            
            imageYOffset += self.view.frame.size.height / self.images.count;
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
