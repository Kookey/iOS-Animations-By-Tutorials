//
//  ViewController.m
//  PackingList
//
//  Created by dudw on 16/5/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"

static NSString  *reuseid = @"Cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

@property(nonatomic,strong) NSArray *itemTitles;
@property(nonatomic,strong) NSArray *items;
@end

@implementation ViewController

- (NSArray *)itemTitles{
    return @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
}

- (NSArray *)items{
    return @[@5,@6,@7];
}
    
- (IBAction)actionToggleMenu:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.rowHeight = 54.0;
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.itemTitles[[self.items[indexPath.row] intValue]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0\%@",self.items[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showItem:indexPath.row];
}

- (void)showItem:(NSInteger)index{
    NSLog(@"%@",self.items[index]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
