//
//  LLContentViewController.m
//  标题悬停
//
//  Created by 周尊贤 on 2018/1/25.
//  Copyright © 2018年 周尊贤. All rights reserved.
//


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#import "LLContentViewController.h"
#import "ViewController.h"

@interface LLContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) CGFloat  lastcontentOffset;

@end

@implementation LLContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LLContentTabView * tabView = [[LLContentTabView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabView = tabView;
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    ViewController  *  parentVc = (ViewController *)self.parentViewController;
    cell.textLabel.text = [NSString stringWithFormat:@"%zd%@",indexPath.row,parentVc.titles[self.index]] ;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //self.oldY = scrollView.contentOffset.y;
   
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.vcCanScroll = false;
        scrollView.contentOffset = CGPointZero;
        ViewController * parentVc = (ViewController *)self.parentViewController;
        parentVc.canScroll = true;
        //parentVc.cell.cellCanScroll = false;
    }
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
