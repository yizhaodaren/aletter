//
//  MOLSystemNotiView.h
//  aletter
//
//  Created by moli-2017 on 2018/8/23.
//  Copyright © 2018年 aletter-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOLSystemNotiView : UIView
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end
