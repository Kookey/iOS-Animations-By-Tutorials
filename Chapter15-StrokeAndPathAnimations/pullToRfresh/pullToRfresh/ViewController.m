//
//  ViewController.m
//  pullToRfresh
//
//  Created by dudawei on 16/6/22.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "ViewController.h"
#import "RefreshView.h"

static const CGFloat kRefreshViewHeight = 110.0;

@interface ViewController ()<RefreshViewDelegate>

@property (nonatomic, strong) NSArray *packItems;
@property (nonatomic, strong) RefreshView *refreshView;

@end

@implementation ViewController

- (NSArray *)packItems{
    if (!_packItems) {
        
        _packItems = @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
    }
    
    return _packItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Vacation pack list";
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:154.0/255.0 blue:222.0/255.0 alpha:1.0];
    self.tableView.rowHeight = 64.0;
    
    
    CGRect refreshRect = CGRectMake(0.0, -kRefreshViewHeight, self.view.frame.size.width, kRefreshViewHeight);
    self.refreshView = [[RefreshView alloc] initWithFrame:refreshRect scrollView:self.tableView];
    self.refreshView.delegate = self;
    [self.view addSubview:self.refreshView];
}

#pragma mark - RefreshViewDelegate
- (void)refreshViewDidRefresh:(RefreshView *)refreshView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshView endRefreshing];
    });
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.refreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self.refreshView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

#pragma mark - Tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.packItems[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%ld.png",(long)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
