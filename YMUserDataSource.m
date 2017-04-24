//
//  YMUserDataSource.m
//  ruying
//
//  Created by Murphy Zheng on 17/4/24.
//  Copyright © 2017年 murphy. All rights reserved.
//

#import "YMUserDataSource.h"

@interface YMUserDataSource ()
@property (nonatomic,strong)RCUserInfo *Cimy;
@property (nonatomic,strong)RCUserInfo *Murphy;
@end
@implementation YMUserDataSource

static NSString *kToken_Murphy = @"Ybr0KwMKopQSv4ZROH5zULnVCnXWTw/yuUqwrhFCEhOf8zfuU/0Ifu/XgPbk2KDiSj0RU2qLMxs=";
static NSString *kToken_Cimy = @"C14ONw4rM9fKOBdq0dKOELnVCnXWTw/yuUqwrhFCEhOf8zfuU/0Ift0tD01Y233TOx3PdrVQew8=";

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    if ([[userId lowercaseString] isEqualToString:@"Cimy"]) {
        completion(self.Cimy);
    }else {
        completion(self.Murphy);
    }
}

- (RCUserInfo *)Cimy {
    if (!_Cimy) {
        _Cimy = [[RCUserInfo alloc] initWithUserId:@"Cimy" name:@"Cimy" portrait:@"http://q.qlogo.cn/headimg_dl?bs=qq&dst_uin=1669868102&src_uin=www.3464.com&fid=blog&spec=640"];
    }
    return _Cimy;
}

- (RCUserInfo *)Murphy {
    if (!_Murphy) {
        _Murphy = [[RCUserInfo alloc] initWithUserId:@"Murphy" name:@"Murphy" portrait:@"http://q.qlogo.cn/headimg_dl?bs=qq&dst_uin=1059957901&src_uin=www.3464.com&fid=blog&spec=640"];
    }
    return _Murphy;
}

@end
