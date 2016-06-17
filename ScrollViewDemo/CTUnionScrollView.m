//
//  UnionScrollView.m
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "CTUnionScrollView.h"
@interface CTUnionScrollView ()<UIScrollViewDelegate,CTSegmentControlDelegate>
{
    NSInteger maxIndex;
    NSInteger minIndex;
    NSInteger showNum;
}
@property (nonatomic,weak)CTSegmentControl *segmentControl;
@property (nonatomic,weak)UIScrollView *titleScrollView;
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger itemCount;
@property (nonatomic,assign)NSInteger currentIndex;
@end

@implementation CTUnionScrollView
+(instancetype)CTUnionScrollViewWithFrame:(CGRect)frame andItems:(NSArray *)items{
    CTUnionScrollView *uniScrollView = [[CTUnionScrollView alloc] initWithFrame:frame andItems:items];
    return uniScrollView;
}
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemCount =items.count;
        CGFloat x = 0,y=0,w=frame.size.width,h=titleSegHeight+separateLienHeight;
        
        UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        titleScrollView.delegate = self;
        titleScrollView.contentSize = CGSizeMake(itemWidth*_itemCount, 0);
        titleScrollView.showsHorizontalScrollIndicator = NO;
        titleScrollView.bounces = NO;
        _titleScrollView = titleScrollView;
        [self addSubview:_titleScrollView];
        
        w=itemWidth*_itemCount;
        h=titleSegHeight;
        CTSegmentControl *segmentControl = [CTSegmentControl CTSegmentControlWithFrame:CGRectMake(x, y, w,h) andItems:items andItemFont:[UIFont systemFontOfSize:14]];
        segmentControl.delegate =self;
        segmentControl.selectedIndex = 0;
        segmentControl.displayRect = YES;
        segmentControl.rectColor = [UIColor grayColor];
        [self addSubview:segmentControl];
        _segmentControl = segmentControl;
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, h, self.frame.size.width, separateLienHeight)];
        separateView.backgroundColor = [self rgb:220 g:221 b:221 a:1.0];
        [self addSubview:separateView];
        [_titleScrollView addSubview:segmentControl];
        y=titleSegHeight+separateLienHeight,h=frame.size.height-titleSegHeight-separateLienHeight,w=frame.size.width;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        scrollView.contentSize = CGSizeMake(w*_itemCount, h);
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
        [self addSubview:scrollView];
        
        for (int i = 0; i<_itemCount; i++) {
            x=i*frame.size.width,y=0,w=frame.size.width,h=frame.size.height-titleSegHeight-separateLienHeight;
            ContentView *view = [[ContentView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
            [scrollView addSubview:view];
            view.tag = 3100+i;
        }
        showNum = (NSInteger)self.frame.size.width/(NSInteger)itemWidth;
        minIndex = 0;
        maxIndex = showNum;
    }
    return self;
}
-(void)segmentControlDidSelectedIndex:(NSInteger)index{
    self.currentIndex = index;
}
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    CGFloat w = self.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(w*_currentIndex, 0) animated:YES];
    ContentView *view = (ContentView*)[_scrollView viewWithTag:3100+_currentIndex];
    if ([self.delegate respondsToSelector:@selector(ct_titleSegmentDidClickIndex:curentView:)]) {
        [self.delegate ct_titleSegmentDidClickIndex:_currentIndex curentView:view];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
        CGFloat tempF = 0;
        if (index>_currentIndex) {//右移
           
            maxIndex = maxIndex>index?maxIndex:index;
            
            if ((maxIndex-minIndex)*itemWidth>_titleScrollView.frame.size.width) {
                minIndex = maxIndex-showNum;
            }
            if ((maxIndex-minIndex+1)*itemWidth>_titleScrollView.frame.size.width) {
                tempF = (showNum+1)*itemWidth-self.frame.size.width;
            }else{
                tempF = 0;
            }
            if (index<showNum) {
                tempF = 0;
            }
        }else if(index<_currentIndex){//左移
            minIndex = minIndex<index?minIndex:index;
            if ((maxIndex-index)*itemWidth>_titleScrollView.frame.size.width) {
                maxIndex = minIndex+showNum;
                
            }
            if ((maxIndex-minIndex+1)*itemWidth<_titleScrollView.frame.size.width) {
                tempF = -(showNum+1)*itemWidth+self.frame.size.width;
            }
            else{
                tempF = 0;
            }
        }else{
            if ((maxIndex-minIndex+1)*itemWidth>_titleScrollView.frame.size.width) {
                tempF = (showNum+1)*itemWidth-self.frame.size.width;
            }
            else{
                tempF = 0;
            }
            if (index==0) {
                tempF = 0;
            }
        }
        
        NSLog(@"max = %ld",maxIndex);
        NSLog(@"min = %ld",minIndex);
        CGFloat temp= minIndex*itemWidth+tempF;
        [_titleScrollView setContentOffset:CGPointMake(temp, 0)];
        self.currentIndex = index;
        _segmentControl.selectedIndex = _currentIndex;
        
    }
}
-(void)ct_currentViewAddView:(UIView *)view withIndex:(NSInteger)index{

    ContentView *currentView = (ContentView*)[_scrollView viewWithTag:3100+index];
    [currentView addSubview:view];
}
-(void)ct_currentViewAddContentTableView:(id<UITableViewDataSource,UITableViewDelegate>)tableViewDelegate{
    for (int i =0; i<_itemCount; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kdeviceWidth, kdeviceHeight-64-45) style:UITableViewStylePlain];
        tableView.delegate = tableViewDelegate;
        tableView.dataSource = tableViewDelegate;
        tableView.backgroundColor = [UIColor clearColor];
        ContentView *currentView = (ContentView*)[_scrollView viewWithTag:3100+i];
        currentView.tableView = tableView;
        [currentView addSubview:tableView];
    }
}
-(void)ct_allViewAddView:(UIView *)view{
    for (int i = 0; i < _itemCount; i++) {
        [self ct_currentViewAddView:[self duplicate:view] withIndex:i];
    }
}
//实现对象的copy，由原对象生成新对象
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
-(UIColor*)rgb:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)alpha{
   return [UIColor colorWithRed:r%256/256.0 green:g%256/256.0 blue:b%256/256.0 alpha:alpha];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
@implementation ContentView
@end