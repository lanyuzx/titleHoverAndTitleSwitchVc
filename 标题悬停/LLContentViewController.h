//
//  LLContentViewController.h
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/25.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLContentTabView.h"
@interface LLContentViewController : UIViewController
@property (nonatomic,assign) NSInteger  index;
@property (nonatomic,weak) LLContentTabView * tabView;
@property (nonatomic, assign) BOOL vcCanScroll;

@end
