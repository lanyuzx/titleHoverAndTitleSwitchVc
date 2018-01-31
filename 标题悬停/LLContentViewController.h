//
//  DemoVC10.h
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/1/20.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLContentTabView.h"
/*
 本demo由SDAutoLayout库的使用者“李西亚”提供，感谢“李西亚”对本库的关注与支持！
 */

@interface LLContentViewController : UIViewController
@property (nonatomic,weak) LLContentTabView * tabView;
@property (nonatomic, assign) BOOL vcCanScroll;
@end
