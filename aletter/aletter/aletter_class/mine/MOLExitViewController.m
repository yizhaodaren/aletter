//
//  MOLExitViewController.m
//  aletter
//
//  Created by moli-2017 on 2018/8/27.
//  Copyright © 2018年 aletter-2018. All rights reserved.
//

#import "MOLExitViewController.h"
#import "MOLHead.h"
#import "MOLChooseBoxCell.h"
#import "MOLActionRequest.h"

@interface MOLExitViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *headButton;

@property (nonatomic, strong) NSMutableArray *datasourceArray;
@property (nonatomic, strong) NSArray *nameArray;
@end

@implementation MOLExitViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasourceArray = [NSMutableArray array];
    self.nameArray = @[@"退出登录",@"留下来"];
    [self setupExitViewControllerUI];
    
    [self request_getDataSource];
    [self.tableView reloadData];
    
    self.headButton.height = MOL_SCREEN_HEIGHT - 30 - MOL_TabbarSafeBottomMargin - self.tableView.contentSize.height;
    self.tableView.tableHeaderView = self.headButton;
}
#pragma mark - 网络请求
- (void)request_getDataSource
{
    MOLChooseBoxModel *left_model = [[MOLChooseBoxModel alloc] init];
    left_model.modelType = MOLChooseBoxModelType_leftText;
    left_model.leftImageString = INTITLE_LEFT_Highlight;
    left_model.leftTitle = @"你要走了吗？";
    left_model.leftHighLight = YES;
    [self.datasourceArray addObject:left_model];
    
    for (NSInteger i = 0; i < self.nameArray.count; i++) {
        MOLChooseBoxModel *model = [[MOLChooseBoxModel alloc] init];
        model.modelType = MOLChooseBoxModelType_rightChooseButton;
        model.buttonTitle = self.nameArray[i];
        [self.datasourceArray addObject:model];
    }
}

#pragma mark - 按钮点击
- (void)button_clickHeadButton
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)button_clickReportButton:(NSString *)reason
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
    
    if (self.exitBlock) {
        self.exitBlock();
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MOLChooseBoxModel *model = self.datasourceArray[indexPath.row];
    if (model.modelType == MOLChooseBoxModelType_rightChooseButton) {
        if ([model.buttonTitle isEqualToString:self.nameArray.lastObject]) {
            [self button_clickHeadButton]; // 返回
        }else{
            [self button_clickReportButton:model.buttonTitle];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MOLChooseBoxModel *model = self.datasourceArray[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MOLChooseBoxModel *model = self.datasourceArray[indexPath.row];
    MOLChooseBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MOLChooseBoxCell_id"];
    cell.boxModel = model;
    if (model.modelType == MOLChooseBoxModelType_rightChooseButton) {
        if ([model.buttonTitle isEqualToString:self.nameArray.firstObject]) {
            [cell chooseBoxCell_drawRadius:2 backgroundColor:HEX_COLOR_ALPHA(0xffffff, 0.2)];
        }else if ([model.buttonTitle isEqualToString:self.nameArray.lastObject]){
            [cell chooseBoxCell_drawRadius:1 backgroundColor:HEX_COLOR_ALPHA(0xffffff, 0.2)];
        }else{
            [cell chooseBoxCell_drawRadius:0 backgroundColor:HEX_COLOR_ALPHA(0xffffff, 0.2)];
        }
    }else{
        [cell chooseBoxCell_drawRadius:0 backgroundColor:HEX_COLOR_ALPHA(0xffffff, 0.2)];
    }
    return cell;
}

#pragma mark - UI
- (void)setupExitViewControllerUI
{
    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MOLChooseBoxCell class] forCellReuseIdentifier:@"MOLChooseBoxCell_id"];
    [self.view addSubview:tableView];
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headButton = headButton;
    [headButton addTarget:self action:@selector(button_clickHeadButton) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = headButton;
}

- (void)calculatorExitViewControllerFrame
{
    self.tableView.frame = self.view.bounds;
    self.headButton.width = self.tableView.width;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self calculatorExitViewControllerFrame];
}
@end
