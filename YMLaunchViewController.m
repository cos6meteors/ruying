//
//  YMLaunchViewController.m
//  ruying
//
//  Created by Murphy Zheng on 17/4/21.
//  Copyright © 2017年 murphy. All rights reserved.
//

#import "YMLaunchViewController.h"
#import "YMConversationListViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>

@interface YMLaunchViewController ()<RCIMConnectionStatusDelegate>

@end

@implementation YMLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"com.murphy.token"];
    
    RCConnectionStatus status = [[RCIM sharedRCIM] getConnectionStatus];
    if ([token length] > 0 && status == ConnectionStatus_Unconnected) {
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            [self showConversationList];
        } error:^(RCConnectErrorCode status) {
            //
            [self showConversationList];
        } tokenIncorrect:^{
            //
            [self showConversationList];
        }];
    }else {
        [self showLogin];
    }
    
}


- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {

    if (status != ConnectionStatus_Connected) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showConversationList];
        });
    }
}

- (void)showConversationList {
    YMConversationListViewController *conversationList = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversationListVC"];
    conversationList.displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
    conversationList.title = @"ruying";
    [self.navigationController setViewControllers:@[conversationList]];
}

- (void)showLogin {
    [self performSegueWithIdentifier:@"LoginVC" sender:nil];
}

@end
