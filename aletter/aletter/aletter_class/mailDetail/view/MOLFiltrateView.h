//
//  MOLFiltrateView.h
//  aletter
//
//  Created by moli-2017 on 2018/8/3.
//  Copyright © 2018年 aletter-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACReplaySubject;
@interface MOLFiltrateView : UIView
@property (nonatomic, strong) RACReplaySubject *commitReplySubject;
- (void)filtrateView_show;
- (void)filtrateView_hidden;

@end
