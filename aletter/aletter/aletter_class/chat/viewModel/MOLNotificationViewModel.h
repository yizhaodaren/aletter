//
//  MOLNotificationViewModel.h
//  aletter
//
//  Created by moli-2017 on 2018/8/24.
//  Copyright © 2018年 aletter-2018. All rights reserved.
//

#import "MOLBaseViewModel.h"
#import "MOLHead.h"
@interface MOLNotificationViewModel : MOLBaseViewModel
@property (nonatomic, strong) RACCommand *notiCommand;
@property (nonatomic, strong) RACCommand *readInteractCommand;
@end
