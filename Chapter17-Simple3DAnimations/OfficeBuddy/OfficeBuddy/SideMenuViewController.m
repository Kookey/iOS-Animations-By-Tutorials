//
//  SideMenuViewController.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MenuItem.h"
#import "ContainerViewController.h"

@interface SideMenuViewController ()

@property(nonatomic,strong) MenuItem *menuItem;
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuItem = [[MenuItem alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItem sharedItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    MenuItem *item = [self.menuItem sharedItems][indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:36.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = item.symbol;
    
    cell.contentView.backgroundColor = item.color;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MenuItem *item = [self.menuItem sharedItems][indexPath.row];
    
    self.centerViewController.menuItem = item;
    
    ContainerViewController *containerVC = (ContainerViewController *)self.parentViewController;
    [containerVC toggleSideMenu];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.0;
}

@end
