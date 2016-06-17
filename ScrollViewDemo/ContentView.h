//
//  ContentView.h
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/17.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView
@property(nonatomic,strong)UITableView *tableView;
-(void)addTableView:(UITableView *)tableView;
@end
