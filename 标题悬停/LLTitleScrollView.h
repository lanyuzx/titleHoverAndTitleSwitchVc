//
//  LLMineGongQiuTitleScrollView.h
//  JLCSteelProject
//
//  Created by 周尊贤 on 2017/8/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTitleScrollView : UIScrollView
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray  *titles;

@property (nonatomic, copy)  void(^buttonSelected)(NSInteger index);


@end
