//
//  ViewController.m
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/25.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "ViewController.h"
#import "LLTitleScrollView.h"
#import "LLContentViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView * scrollView;
@property (nonatomic,weak) LLTitleScrollView * titleScrollView;
@property (nonatomic, assign) NSInteger  currentIndex;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titles = @[@"精选",@"婚礼策划",@"婚纱摄影",@"婚礼金沙",@"四大金刚"];
    for (NSString *  title in self.titles) {
        LLContentViewController * contentVc = [LLContentViewController new];
        contentVc.title = title;
        [self addChildViewController:contentVc];
    }
    self.canScroll = true;
    UIView * tabHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 900)];
    tabHeaderView.backgroundColor = [UIColor yellowColor];
    UITableView * tabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabView = tabView;
    tabView.showsVerticalScrollIndicator = false;
    tabView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.tableHeaderView = tabHeaderView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
   
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeScrollStatus//改变主视图的状态
{
    //self.canScroll = YES;
    //self.contentCell.cellCanScroll = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"dequeueReusableHeaderFooterViewWithIdentifier"];
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 45)];
         view.backgroundColor = [UIColor greenColor];
        LLTitleScrollView * titleScroView = [[LLTitleScrollView alloc]initWithFrame:view.bounds];
        self.titleScrollView = titleScroView;
        [view addSubview:titleScroView];
        titleScroView.titles = self.titles;
        __weak typeof(self) weak = self;
        titleScroView.buttonSelected = ^(NSInteger index) {
            [weak.scrollView setContentOffset:CGPointMake(CGRectGetWidth(weak.view.frame) * index, 0) animated:true];
        };
    
    }
   
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
       // self.cell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor redColor];
        //cell.viewControllers = self.childViewControllers;
        
        
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
        self.scrollView = scrollView;
        [cell.contentView addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.pagingEnabled = true;
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.titles.count, 0);
        
        LLContentViewController * firstContentVc = self.childViewControllers.firstObject;
        firstContentVc.index = 0 ;
        [scrollView addSubview:firstContentVc.view];
        firstContentVc.view.frame = scrollView.bounds;
        firstContentVc.view.backgroundColor = [UIColor brownColor];
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGRectGetHeight(self.view.frame)-64;
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
        CGFloat offSetX = scrollView.contentOffset.x;
        NSInteger index = offSetX / CGRectGetWidth(self.view.frame);
        self.currentIndex = index;
        self.titleScrollView.selectedIndex = index;
        LLContentViewController * childVc = self.childViewControllers[index];
        childVc.index = index;
         childVc.view.backgroundColor = [UIColor brownColor];
        if (index %2) {
            childVc.view.backgroundColor = [UIColor blueColor];
        }
        [scrollView addSubview:childVc.view];
        childVc.view.frame =scrollView.bounds;
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        return;
    }
    CGFloat bottomCellOffset = [self.tabView rectForSection:0].origin.y-64;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LLContentViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.vcCanScroll = true;
                if (!obj.vcCanScroll) {
                    obj.tabView.contentOffset = CGPointZero;
                }
            }];
          //  self.cell.cellCanScroll = YES;
            
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tabView.showsVerticalScrollIndicator = _canScroll?YES:NO;
    
}






@end
