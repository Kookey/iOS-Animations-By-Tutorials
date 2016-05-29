//
//  ViewController.m
//  PackingList
//
//  Created by dudw on 16/5/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalItemList.h"

static NSString  *reuseid = @"Cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHeightConstraint;

@property(nonatomic,strong) NSArray *itemTitles;
//@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,assign) BOOL isMenuOpen;
@property(nonatomic,strong) HorizontalItemList *slider;
@end

@implementation ViewController{
    __block NSMutableArray *items;
}

- (NSArray *)itemTitles{
    return @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
}

- (NSMutableArray *)getItems{
    if (items.count == 0) {
       items = [@[@5,@6,@7] mutableCopy];
    }
    
    return items;
}

- (IBAction)actionToggleMenu:(id)sender {
    
//    for (NSLayoutConstraint *con in self.titleLabel.superview.constraints) {
//        
//    }
    
    self.isMenuOpen = !self.isMenuOpen;
    
    for (NSLayoutConstraint *con  in self.titleLabel.superview.constraints) {
        if (con.firstItem == self.titleLabel && con.firstAttribute == NSLayoutAttributeCenterX) {
            con.constant = self.isMenuOpen ? -100 : 0.0;
            continue;
        }
        
        if ([con.identifier isEqualToString:@"TitleCenterY"]) {
            con.active = NO;
            
            NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeCenterY multiplier:self.isMenuOpen ? 0.66 : 1.0 constant:5.0];
            newConstraint.active = YES;
            
            continue;
        }
        
        
        self.menuHeightConstraint.constant = self.isMenuOpen ? 200 : 66.0;
        self.titleLabel.text = self.isMenuOpen ? @"Select Item" : @"Packing List";
        
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.view layoutIfNeeded];
            CGFloat angle = self.isMenuOpen ? M_PI_4 : 0.0;
            self.buttonMenu.transform = CGAffineTransformMakeRotation(angle);
        } completion:nil];
        
        
        if (self.isMenuOpen) {
            
            if (self.slider) {
               [self.slider removeFromSuperview];
            }
            self.slider = [[HorizontalItemList alloc] initInView:self.view];
            
             __weak typeof(self) weakSelf = self;
            
            self.slider.selectItem = ^(NSInteger index){
//                NSLog(@"add %d",index);
                [items addObject:@(index)];
                [weakSelf.tableview reloadData];
                [weakSelf actionToggleMenu:weakSelf];
            };
            
            [self.titleLabel.superview addSubview:self.slider];
        } else {
            [self.slider removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.rowHeight = 54.0;
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = self.itemTitles[[items[indexPath.row] intValue]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0\%@",items[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showItem:indexPath.row];
}

- (void)showItem:(NSInteger)index{
    NSLog(@"%@",items[index]);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%ld",(long)index]]];
    imageView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    NSLayoutConstraint *conX = [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
    NSLayoutConstraint *conBottom = [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:imageView.frame.size.height];
    NSLayoutConstraint *conWidth = [imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.33 constant:-50];
    NSLayoutConstraint *conHeight = [imageView.heightAnchor constraintEqualToAnchor:imageView.widthAnchor];
    
    [NSLayoutConstraint activateConstraints:@[conX,conBottom,conWidth,conHeight]];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        conBottom.constant = -imageView.frame.size.height / 2;
        conWidth.constant = 0.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.8 delay:1.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        conBottom.constant = imageView.frame.size.height;
        conWidth.constant = -50;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
