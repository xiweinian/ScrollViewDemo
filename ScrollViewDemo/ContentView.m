//
//  ContentView.m
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/17.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
-(void)addTableView:(UITableView *)tableView{
    _tableView = tableView;
    [self addSubview:tableView];
}
    /*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
