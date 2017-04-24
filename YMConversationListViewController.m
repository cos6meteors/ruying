//
//  YMConversationListViewController.m
//  ruying
//
//  Created by Murphy Zheng on 17/4/21.
//  Copyright © 2017年 murphy. All rights reserved.
//

#import "YMConversationListViewController.h"
#import "YMConversationViewController.h"
#import "YMLaunchViewController.h"

@interface YMConversationListViewController ()

@end

static NSString *kTarget_Murphy = @"Murphy";
static NSString *kTarget_Cimy   = @"Cimy";

@implementation YMConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conversationListTableView.tableFooterView = [UIView new];
    self.showConnectingStatusOnNavigatorBar = YES;
    self.isShowNetworkIndicatorView = NO;
    
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction)];
    self.navigationItem.leftBarButtonItem = logoutItem;
    
    UIBarButtonItem *talkItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStyleDone target:self action:@selector(toConversationAction)];
    self.navigationItem.rightBarButtonItem = talkItem;
    
}

- (void)onSelectedTableRow:(RCConversationModelType)type conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    YMConversationViewController *conversation = [[YMConversationViewController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
    conversation.title = model.targetId;
    [self.navigationController pushViewController:conversation animated:YES];
    
    
}
- (void)logoutAction {
    [[RCIM sharedRCIM] logout];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.murphy.token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    YMLaunchViewController *launch = [self.storyboard instantiateViewControllerWithIdentifier:@"LaungchVC"];
    [self.navigationController setViewControllers:@[launch] animated:YES];
}

- (void)toConversationAction {
    NSString *targatID = kTarget_Murphy;
    
    if ([[[RCIMClient sharedRCIMClient] currentUserInfo].userId isEqualToString:targatID]) {
        targatID = kTarget_Cimy;
    }
    
    YMConversationViewController *conversation = [[YMConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targatID];
    conversation.title = targatID;
    [self.navigationController pushViewController:conversation animated:YES];
}

@end
