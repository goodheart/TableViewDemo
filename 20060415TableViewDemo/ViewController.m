//
//  ViewController.m
//  20060415TableViewDemo
//
//  Created by majian on 16/4/15.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "ViewController.h"
#import "SNHTableViewCell.h"
#import "SNHTableViewCellModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSUInteger _auth;
}

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<SNHTableViewCellModel *> * dataSourceArrayM;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //实现角色的改变的简单做法
    UIBarButtonItem * navItem = [[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshAction)];
    self.navigationItem.rightBarButtonItem = navItem;
    
    _auth = 1;
    [self _createDataSource];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArrayM.count;
}

//该方法应该尽快返回cell，不应该有多余的计算
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SNHTableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SNHTableViewCell class]) forIndexPath:indexPath];
    
    //考虑性能优化，赋值代码也可以放到cellWillDisplay方法中
    if (indexPath.row >= 0 &&
        indexPath.row < self.dataSourceArrayM.count) { //防止数组越界
        cell.model = self.dataSourceArrayM[indexPath.row];
    }
    
    return cell;
}

#if 0
- (void)tableView:(UITableView *)tableView willDisplayCell:(SNHTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 0 &&
        indexPath.row < self.dataSourceArrayM.count) { //防止数组越界
        cell.model = self.dataSourceArrayM[indexPath.row];
    }
}
#endif
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 0 && indexPath.row < self.dataSourceArrayM.count) {
        SNHTableViewCellModel * model = self.dataSourceArrayM[indexPath.row];
        //执行方法
        [self performSelector:NSSelectorFromString(model.actionName)
                   withObject:nil
                   afterDelay:0.0];
    }
}

#pragma mark - Private Method
/*!
 *  负责创建数据源
 */
- (void)_createDataSource {
    
    if (_dataSourceArrayM == nil) {
        _dataSourceArrayM = [NSMutableArray new];
    }
    
    [self.dataSourceArrayM removeAllObjects];
    
    /*
     根据当前的角色或者运营的要求决定是否存在甚至读取服务器的配置文件实现顺序的改变，使用target-action模式可以保持代码的干净整洁，否则还要在返回UITableViewCell以及didSelect方法中进行判断
     */
    
    if (_auth <= 2) {
        SNHTableViewCellModel * model = [[SNHTableViewCellModel alloc] init];
        model.backColor = [UIColor blueColor];
        model.actionName = @"AAction"; //根据个人习惯可以用NSString也可以直接存储selector,为了解耦也可以指定target，比如可以指定到对应的vm，根据具体需求走
        [self.dataSourceArrayM addObject:model];
    }
    
    if (_auth > 2) {
        SNHTableViewCellModel * model = [SNHTableViewCellModel new];
        model.backColor = [UIColor orangeColor];
        model.actionName = @"BAction";
        [self.dataSourceArrayM addObject:model];
    }
    
    if (_auth > 1 && _auth <= 5) {
        SNHTableViewCellModel * model = [SNHTableViewCellModel new];
        model.backColor = [UIColor purpleColor];
        model.actionName = @"CAction";
        [self.dataSourceArrayM addObject:model];
    }
}

#pragma mark - Response
- (void)AAction {
    NSLog(@"AAction");
}

- (void)BAction {
    NSLog(@"BAction");
}

- (void)CAction {
    NSLog(@"CAction");
}

- (void)refreshAction {
    _auth += 1;
    [self _createDataSource];
    [self.tableView reloadData];
}

#pragma mark - Lazy Initialization
- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SNHTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SNHTableViewCell class])];
    
    return _tableView;
    
}

@end












