//
//  YMUserViewController.m
//  ruying
//
//  Created by Murphy Zheng on 17/4/21.
//  Copyright © 2017年 murphy. All rights reserved.
//

#import "YMUserViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface YMUserViewController ()

@end

static NSString *kTokenA = @"Ybr0KwMKopQSv4ZROH5zULnVCnXWTw/yuUqwrhFCEhOf8zfuU/0Ifu/XgPbk2KDiSj0RU2qLMxs=";
static NSString *kTokenB = @"C14ONw4rM9fKOBdq0dKOELnVCnXWTw/yuUqwrhFCEhOf8zfuU/0Ift0tD01Y233TOx3PdrVQew8=";

@implementation YMUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)selectedBoy:(id)sender {
    [self connectWithToken:kTokenA sender:sender];
}
- (IBAction)selectedGirl:(id)sender {
    [self connectWithToken:kTokenB sender:sender];
}

- (void)connectWithToken:(NSString *)token sender:(UIButton *)sender {
    sender.enabled = false;
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        sender.enabled = true;
        [self loginSuccess:token];
    } error:^(RCConnectErrorCode status) {
        sender.enabled = true;
        if (status == RC_CHATROOM_NOT_EXIST) {
            [self loginSuccess:token];
        }else {
            NSLog(@"[error] token in correct");
        }
    } tokenIncorrect:^{
        sender.enabled = true;
        NSLog(@"登录失败，是不是没网了");
    }];
}

- (void)loginSuccess:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.murphy.token"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"com.murphy.token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
