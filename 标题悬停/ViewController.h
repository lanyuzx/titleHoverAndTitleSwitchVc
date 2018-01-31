//
//  ViewController.h
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/25.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) NSArray <NSString *> * titles;
@property (nonatomic,weak) UITableView * tabView;
@property (nonatomic, assign) BOOL canScroll;

@end

