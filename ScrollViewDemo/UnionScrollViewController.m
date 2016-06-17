//
//  UnionScrollViewController.m
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "UnionScrollViewController.h"
#import "CTUnionScrollView.h"
@interface UnionScrollViewController ()<CTUnionScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentIndex;
}
@end

@implementation UnionScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    NSArray *items = @[@"标签1",@"标签2",@"标签3",@"标签4",@"标签5",@"标签6",@"标签7",@"标签8",@"标签9"];
    CTUnionScrollView *unionScrollView = [CTUnionScrollView CTUnionScrollViewWithFrame:CGRectMake(0, 0, kdeviceWidth, kdeviceHeight-64) andItems:items];
    [self.view addSubview:unionScrollView];
    unionScrollView.delegate=self;
    [unionScrollView ct_currentViewAddContentTableView:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ct_titleSegmentDidClickIndex:(NSInteger)index curentView:(ContentView *)currentView{
    _currentIndex = index;
    if (currentView.tableView) {
        [currentView.tableView reloadData];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"✨✨✨✨✨标签%ld  cell-%ld",(long)_currentIndex+1,(long)indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Impact" size:15];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
