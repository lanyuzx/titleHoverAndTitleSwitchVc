//
//  LLMineGongQiuTitleScrollView.m
//  JLCSteelProject
//
//  Created by 周尊贤 on 2017/8/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "LLTitleScrollView.h"
@interface LLTitleScrollView()
@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic,assign) CGFloat  sliderViewWith;

@property (nonatomic,strong) NSMutableArray * titleButtons;

@property (nonatomic,weak) UIColor *titleNormalColor;
@property (nonatomic,weak) UIColor * tileSelecteColor;
@property (nonatomic,weak) UIColor * sliderColor;
@property (nonatomic,assign) NSInteger screeVisibleCount;

@property (nonatomic,assign) BOOL bottonIsClick;
@end
@implementation LLTitleScrollView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
//        self.titleNormalColor = normalColor;
//        self.tileSelecteColor = selecteColor;
//        self.sliderColor = sliderColor;
//        self.screeVisibleCount = screeVisibleCount;
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Event Response
- (void)titleButtonClicked:(UIButton *)button
{

    if (![button isKindOfClass:[UIButton class]]) {
        return;
    }
    _selectedIndex = button.tag;
    if (self.buttonSelected)
    {
        self.buttonSelected(button.tag);
    }
    if (self.selectedButton)
    {
        self.selectedButton.selected = false;
    }
    button.selected = true ;
    self.selectedButton = button;

    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.center=CGPointMake(button.center.x, self.sliderView.center.y);
    }];
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = button.center.x - (SCREEN_WIDTH )  * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算下最大的标题视图滚动区域
    
    CGFloat maxOffsetX = self.contentSize.width - (SCREEN_WIDTH );
    if (self.titles.count <= 3) { //有两个标题情况,不设置
        maxOffsetX = self.contentSize.width - (SCREEN_WIDTH);
        
    }
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - Private Method

#pragma mark - Setters And Getters

- (UIView *)sliderView
{
    if (!_sliderView)
    {
        UIView* sliderView = [[UIView alloc] init];
        sliderView.backgroundColor = self.sliderColor ? self.sliderColor:[UIColor redColor];
        sliderView.layer.cornerRadius = 2;
        sliderView.clipsToBounds = YES;
        _sliderView = sliderView;
    }
    return _sliderView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    self.bottonIsClick = false;
    _selectedIndex = selectedIndex;
    UIButton* button = self.titleButtons[selectedIndex];
    if (![button isKindOfClass:[UIButton class]]) {
        return;
    }
    _selectedIndex = button.tag;
    if (self.selectedButton)
    {
        self.selectedButton.selected = false;
    }
    button.selected = true ;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.center=CGPointMake(button.center.x, self.sliderView.center.y);
    }];
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = button.center.x - (SCREEN_WIDTH )  * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算下最大的标题视图滚动区域
    
    CGFloat maxOffsetX = self.contentSize.width - (SCREEN_WIDTH );
    if (self.titles.count <= 3) { //有两个标题情况,不设置
        maxOffsetX = self.contentSize.width - (SCREEN_WIDTH);
        
    }
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)setTitles:(NSArray *)titles
{
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
    }
    if (titles.count <1) {
        return;
    }
    [self.titleButtons removeAllObjects];
    _titles = titles;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width ) / _titles.count ;
    
    self.sliderViewWith = width;
    
    self.contentSize = CGSizeMake(titles.count *width, 0);
    
    for ( int i = 0; i<titles.count; i++ )
    {
        UIButton* titleButton = [self titleButton:titles[i]];
        titleButton.tag = i;
        [self addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        titleButton.frame = CGRectMake(i * width, 0, width, 43);
        if (i == 0)
        {
            titleButton.selected = YES;
            self.selectedButton = titleButton;
        }
    }
    UIButton* button = self.titleButtons[0];
    if (self.selectedButton != nil) {
        button = self.titleButtons[self.selectedIndex];
    }
    
    [self addSubview:self.sliderView];
    
    self.sliderView.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height, button.frame.size.width, 2);
    
}

- (UIButton *)titleButton:(NSString *)title
{
    UIButton* titleButton = [[UIButton alloc] init];
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [titleButton setTitleColor:self.tileSelecteColor ?self.tileSelecteColor:[UIColor redColor] forState:UIControlStateSelected];
    [titleButton setTitleColor:self.titleNormalColor ? self.titleNormalColor :[UIColor darkGrayColor] forState:UIControlStateNormal];
    [titleButton setTitle:title forState:UIControlStateNormal];
    titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return titleButton;
}

-(NSMutableArray *)titleButtons{
    
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray arrayWithCapacity:8];
    }
    return _titleButtons;
}


@end
