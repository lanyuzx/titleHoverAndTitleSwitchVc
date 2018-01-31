//
//  LLTabViewHeaderView.m
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/29.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLTabViewHeaderView.h"
#import "UUMarqueeView.h"
@interface LLTabViewHeaderView()<UUMarqueeViewDelegate>
@end
@implementation LLTabViewHeaderView
{
    UUMarqueeView * _simpleMarqueeView;
}
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}


-(void)setupUI {
    
    SDCycleScrollView * sdcycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:true imageNamesGroup:@[@"h1",@"h2",@"h3",@"h4"]];
    [self addSubview:sdcycleView];
    sdcycleView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .heightIs(220);
    
    _simpleMarqueeView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(0, 220, CGRectGetWidth(self.frame), 30)];
    _simpleMarqueeView.delegate = self;
    _simpleMarqueeView.timeIntervalPerScroll = 2.0f;
    _simpleMarqueeView.timeDurationPerScroll = 1.0f;
    [self addSubview:_simpleMarqueeView];
     [_simpleMarqueeView start];
    [_simpleMarqueeView reloadData];
   
}
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView *)marqueeView {
    return 1;
}
- (void)createItemView:(UIView *)itemView forMarqueeView:(UUMarqueeView *)marqueeView {
    itemView.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1.0f];
    
    UILabel *content = [[UILabel alloc] initWithFrame:itemView.bounds];
    content.font = [UIFont systemFontOfSize:14.0f];
    content.tag = 1001;
    [itemView addSubview:content];
}

- (NSArray *)dataSourceArrayForMarqueeView:(UUMarqueeView *)marqueeView {
    NSArray * simpleMarqueeViewData = @[@"习近平全票当选第十三届全国人大代表",
                                        @"十三届全国人大一次会议于3月5日召开 北京两会",
                                        @"豆瓣阅读能让豆瓣重振声威么？",
                                        @"英国首相今起访华 新年伊始中欧互动频密"
                                        ];
    
    return simpleMarqueeViewData;
}



- (void)updateItemView:(UIView *)itemView withData:(id)data forMarqueeView:(UUMarqueeView *)marqueeView {
    UILabel *content = [itemView viewWithTag:1001];
    content.text = data;
}



@end
