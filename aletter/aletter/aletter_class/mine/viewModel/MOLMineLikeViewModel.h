//
//  MOLMineLikeViewModel.h
//  aletter
//
//  Created by moli-2017 on 2018/8/17.
//  Copyright © 2018年 aletter-2018. All rights reserved.
//

#import "MOLBaseViewModel.h"
#import "MOLHead.h"

@interface MOLMineLikeViewModel : MOLBaseViewModel
@property (nonatomic, strong) RACCommand *likeStoryCommand;
@end
