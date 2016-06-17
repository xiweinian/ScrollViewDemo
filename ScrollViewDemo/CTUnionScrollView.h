//
//  UnionScrollView.h
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSegmentControl.h"
//#import "ContentView.h"
#define itemWidth 60
#define titleSegHeight 40
#define separateLienHeight 5
#define kdeviceWidth [UIScreen mainScreen].bounds.size.width
#define kdeviceHeight [UIScreen mainScreen].bounds.size.height

@interface ContentView : UIView
@property(nonatomic,strong)UITableView *tableView;
@end


@protocol CTUnionScrollViewDelegate <NSObject>

/**第几个标题被选中时*/
-(void)ct_titleSegmentDidClickIndex:(NSInteger)index curentView:(ContentView*)currentView;
@end

@interface CTUnionScrollView : UIView
@property(nonatomic,assign)id<CTUnionScrollViewDelegate> delegate;
+(instancetype)CTUnionScrollViewWithFrame:(CGRect)frame andItems:(NSArray *)items;
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items;
/**在第index个contentView上添加控件*/
-(void)ct_currentViewAddView:(UIView*)view withIndex:(NSInteger)index;
/**在所有的contentView上相同的位置同时添加控件*/
-(void)ct_allViewAddView:(UIView*)view;
/**给contentView添加tableview并且指定tableview的代理*/
-(void)ct_currentViewAddContentTableView:(id<UITableViewDataSource,UITableViewDelegate>)tableViewDelegate;
@end
