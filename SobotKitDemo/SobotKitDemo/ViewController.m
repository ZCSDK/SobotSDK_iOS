//
//  ViewController.m
//  SobotKitFrameworkTest
//
//  Created by zhangxy on 15/11/21.
//  Copyright © 2015年 zhichi. All rights reserved.
//

#import "ViewController.h"
#import "UserInformationViewController.h"

#import <SobotKit/SobotKit.h>
#import "AppDelegate.h"


@interface ViewController (){
    UIView *menuView;
    int     _type ;
    UISwitch * _imagePickerSwitch;
    UIColor * _selectedColor;
    int     _aidTurn;
    NSString *titleType;
}


@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self layoutCoustomUI];
    _bgScrollView.scrollEnabled = YES;
    _bgScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 2200);
    self.title = @"智齿SDK_iOS";
}


-(IBAction)buttonClick:(UIButton *)sender{
    
    
    //  初始化配置信息
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    
    [self setZCLibInitInfoParam:initInfo];
    
    //自定义用户参数
    [self customUserInformationWith:initInfo];
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    
    
    // 自定义UI(设置背景颜色相关)
    [self customerUI:uiInfo];
    
    
    // 之定义商品和留言页面的相关UI
    [self customerGoodAndLeavePageWithParameter:uiInfo];
    
    // 未读消息
    [self customUnReadNumber:uiInfo];
    
    // 测试模式
    [ZCSobot setShowDebug:NO];
    
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    
    // 启动
//    [ZCSobot startZCChatView:uiInfo with:self pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
//        // 点击返回
//        if(type==ZCPageBlockGoBack){
//            NSLog(@"点击了关闭按钮");
//        }
//        
//        // 页面UI初始化完成，可以获取UIView，自定义UI
//        if(type==ZCPageBlockLoadFinish){
//            
//        }
//    } messageLinkClick:nil];
    
    
    
    ZCUIChatController *chatController = [[ZCUIChatController alloc] initWithInitInfo:uiInfo];
    [chatController setPageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        // 点击返回
        if(type==ZCPageBlockGoBack){
            NSLog(@"点击了关闭按钮");
        }
        
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            
        }
    } messageLinkClick:nil];
    
    [self presentViewController:chatController animated:YES completion:nil];
    
    
    
    
}

- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"40a39d3bc242425399a99099d74edc0a";
    initInfo.skillSetId = _groupIdTF.text;
    initInfo.skillSetName = _groupNameTF.text;
    initInfo.receptionistId = _aidTF.text;
    initInfo.robotId = _robotIdTF.text;
    initInfo.tranReceptionistFlag = _aidTurn;
    initInfo.scopeTime = [_historyScopeTF.text intValue];
    initInfo.titleType = titleType;
    initInfo.customTitle = _titleCustomTF.text;
    
}


// 设置UI部分
-(void) customerUI:(ZCKitInfo *) kitInfo{
    kitInfo.isCloseAfterEvaluation = YES;
    // 点击返回是否触发满意度评价（符合评价逻辑的前提下）
    kitInfo.isOpenEvaluation = _isBackSwitch.on;
    // 如果isShowTansfer=NO 通过记录机器人未知说辞的次数，设置显示转人工按钮，默认1次;
    kitInfo.unWordsCount = _robotUnknowCount.text;
    // 是否显示语音按钮
    kitInfo.isOpenRecord = _isOpenVideoSwitch.on;
    
    // 是否显示转人工按钮
    kitInfo.isShowTansfer    = _isShowTansferSwitch.on;
    // 评价完人工是否关闭会话
    kitInfo.isCloseAfterEvaluation = _isCloseSessionWhenBackSwitch.on;
    
    /**
     *  自定义信息
     */
    // 顶部导航条标题文字 评价标题文字 系统相册标题文字 评价客服（立即结束 取消）按钮文字
    //    kitInfo.titleFont = [UIFont systemFontOfSize:30];
    
    // 返回按钮      输入框文字   评价客服是否有以下情况 label 文字  提价评价按钮
    //    kitInfo.listTitleFont = [UIFont systemFontOfSize:22];
    
    //没有网络提醒的button 没有更多记录label的文字    语音tipLabel的文字   评价不满意（4个button）文字  占位图片的lablel文字   语音输入时间label文字   语音输入的按钮文字
    //    kitInfo.listDetailFont = [UIFont systemFontOfSize:25];
    
    // 录音按钮的文字
    //    kitInfo.voiceButtonFont = [UIFont systemFontOfSize:25];
    // 消息提醒 （转人工、客服接待等）
    //    kitInfo.listTimeFont = [UIFont systemFontOfSize:22];
    
    // 聊天气泡中的文字
    //    kitInfo.chatFont  = [UIFont systemFontOfSize:22];
    
    // 聊天的背景颜色
    //    kitInfo.backgroundColor = [UIColor redColor];
    
    // 导航、客服气泡、线条的颜色
    //        kitInfo.customBannerColor  = [UIColor redColor];
    
    // 左边气泡的颜色
    //        kitInfo.leftChatColor = [UIColor redColor];
    
    // 右边气泡的颜色
    //        kitInfo.rightChatColor = [UIColor redColor];
    
    // 底部bottom的背景颜色
    //    kitInfo.backgroundBottomColor = [UIColor redColor];
    
    // 底部bottom的输入框线条背景颜色
    //    kitInfo.bottomLineColor = [UIColor redColor];
    
    // 提示气泡的背景颜色
    //    kitInfo.BgTipAirBubblesColor = [UIColor redColor];
    
    // 顶部文字的颜色
    //    kitInfo.topViewTextColor  =  [UIColor redColor];
    
    // 提示气泡文字颜色
    //        kitInfo.tipLayerTextColor = [UIColor redColor];
    
    // 评价普通按钮选中背景颜色和边框(默认跟随主题色customBannerColor)
    //        kitInfo.commentOtherButtonBgColor=[UIColor redColor];
    
    // 评价(立即结束、取消)按钮文字颜色(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonColor = [UIColor redColor];
    
    //评价提交按钮背景颜色和边框(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonBgColor = [UIColor redColor];
    
    //    评价提交按钮点击后背景色，默认0x089899, 0.95
    //    kitInfo.commentCommitButtonBgHighColor = [UIColor yellowColor];
    
    // 左边气泡文字的颜色
    //    kitInfo.leftChatTextColor = [UIColor redColor];
    
    // 右边气泡文字的颜色[注意：语音动画图片，需要单独替换]
    //    kitInfo.rightChatTextColor  = [UIColor redColor];
    
    // 时间文字的颜色
    //    kitInfo.timeTextColor = [UIColor redColor];
    
    // 客服昵称颜色
    //        kitInfo.serviceNameTextColor = [UIColor redColor];
    
    
    // 提交评价按钮的文字颜色
    //    kitInfo.submitEvaluationColor = [UIColor redColor];
    
    // 相册的导航栏背景颜色
    
    //    kitInfo.imagePickerColor = _selectedColor;
    // 相册的导航栏标题的文字颜色
    //    kitInfo.imagePickerTitleColor = [UIColor redColor];
    
    // 左边超链的颜色
    //        kitInfo.chatLeftLinkColor = [UIColor blueColor];
    
    // 右边超链的颜色
    //        kitInfo.chatRightLinkColor =[UIColor redColor];
    
    // 提示客服昵称的文字颜色
    //    kitInfo.nickNameTextColor = [UIColor redColor];
    // 相册的导航栏是否设置背景图片(图片来自SobotKit.bundle中ZCIcon_navcBgImage)
    //    kitInfo.isSetPhotoLibraryBgImage = YES;
    
    // 富媒体cell中线条的背景色
    //    kitInfo.LineRichColor = [UIColor redColor];
    
    //    // 语音cell选中的背景颜色
    //    kitInfo.videoCellBgSelColor = [UIColor redColor];
    //
    //    // 商品cell中标题的文字颜色
    //    kitInfo.goodsTitleTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中摘要的文字颜色
    //    kitInfo.goodsDetTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中标签的文字颜色
    //    kitInfo.goodsTipTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中发送的文字颜色
    //    kitInfo.goodsSendTextColor = [UIColor redColor];
    
    // 发送按钮的背景色
    //        kitInfo.goodSendBtnColor = [UIColor yellowColor];
    
    // “连接中。。。”  button 的背景色和文字的颜色
    //    kitInfo.socketStatusButtonBgColor  = [UIColor yellowColor];
    //    kitInfo.socketStatusButtonTitleColor = [UIColor redColor];
}



//屏幕点击事件
- (void)didTapAnywhere1:(UITapGestureRecognizer *)recognizer {
    [_appKeyTF resignFirstResponder];
    [_hostTF resignFirstResponder];
    [_userIdTF resignFirstResponder];
    [_goodTagTF resignFirstResponder];
    [_goodsImgTF resignFirstResponder];
    [_goodsSendTF resignFirstResponder];
    [_goodsTitleTF resignFirstResponder];
    [_goodsSummaryTF resignFirstResponder];
    [_groupNameTF resignFirstResponder];
    [_groupIdTF resignFirstResponder];
    [_aidTF resignFirstResponder];
    [_robotIdTF resignFirstResponder];
    [_titleCustomTF resignFirstResponder];
    [_historyScopeTF resignFirstResponder];
    [_robotUnknowCount resignFirstResponder];
    
}

// 配置用户资料
- (IBAction)userInformation:(id)sender {
    UserInformationViewController *userVC = [[UserInformationViewController alloc]init];
    [self.navigationController pushViewController:userVC animated:YES];
}

-(IBAction)buttonCloseSession:(id)sender{
    [ZCLibClient closeAndoutZCServer:YES];
}

// 离线消息
- (void)offLineAction:(UIButton *)btn{
    [[ZCLibClient getZCLibClient] setAutoNotification:YES];
    _offLineMsgCount.text = @"0";
    _offLineMsgCount.hidden = YES;
    if (btn.tag == 201) {
        [ZCLibClient getZCLibClient].receivedBlock=^(id obj,int unRead){
            NSLog(@"未读消息数量：\n%d,%@",unRead,obj);
            if(unRead>0){
                _offLineMsgCount.hidden = NO;
                _offLineMsgCount.text = [NSString stringWithFormat:@"%d",unRead];
            }else{
                _offLineMsgCount.hidden = YES;
                _offLineMsgCount.text = @"0";
            }
        };
        [self.openOffLineMsgBtn setTitle:@"关闭离线消息" forState:UIControlStateNormal];
        btn.tag =202;
    }else{
        [ZCLibClient  closeAndoutZCServer:YES];
        [self.openOffLineMsgBtn setTitle:@"开启离线消息" forState:UIControlStateNormal];
        btn.tag = 201;
        
    }
}

// 关闭推送
-(void)btnClosePush:(UIButton *) btn{
    
    [[ZCLibClient getZCLibClient] removePush:^(NSString *uid, NSData *token, NSError *error) {
        if((uid==nil &&  token==nil) || error!=nil){
            
        }else{

        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 自定义用户信息参数
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    initInfo.userId         = _userIdTF.text;
    //    initInfo.customInfo = @{@"标题1":@"自定义1",@"内容1":@"我是一个自定义字段。",@"标题2":@"自定义字段2",@"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",@"标题3":@"自定义字段字段3",@"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"标题4":@"自定义4",@"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"};
    
    NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
    initInfo.email        = [user valueForKey:@"email"];
    initInfo.avatarUrl    = [user valueForKey:@"avatarUrl"];
    initInfo.sourceURL    = [user valueForKey:@"sourceURL"];
    initInfo.sourceTitle  = [user valueForKey:@"sourceTitle"];
    initInfo.serviceMode  = _type;
    
    // 以下字段为方便测试使用，上线打包时注掉
    initInfo.phone       = [user valueForKey:@"phone"];
    initInfo.nickName    = [user valueForKey:@"nickName"];
    // 微信，微博，用户的真实昵称，生日，备注性别 QQ号
    // 生日字段用户传入的格式，例：20170323，如果不是这个格式，初始化接口会给过滤掉
    
    initInfo.qqNumber = [user valueForKey:@"qqNumber"];
    initInfo.userSex = [user valueForKey:@"userSex"];
    initInfo.realName = [user valueForKey:@"useName"];
    initInfo.weiBo = [user valueForKey:@"weiBo"];
    initInfo.weChat = [user valueForKey:@"weChat"];
    initInfo.userBirthday = [user valueForKey:@"userBirthday"];
    initInfo.userRemark = [user valueForKey:@"userRemark"];
    
    
    //    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:initInfo.phone,@"tel",useName,@"realname",initInfo.email,@"email",initInfo.nickName,@"uname" ,weChat,@"weixin",weibo,@"weibo",sex,@"sex",userBirthday,@"birthday",userRemark,@"remark",initInfo.avatarUrl,@"face",qq,@"qq",initInfo.sourceURL,@"visitUrl",initInfo.sourceTitle,@"visitTitle",@"自定义1",@"标题1",@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"内容3",nil];
    //    initInfo.customInfo = dict;
    initInfo.customInfo = @{
                            
                            @"标题1":@"自定义1",
                            @"内容1":@"我是一个自定义字段。",
                            @"标题2":@"自定义字段2",
                            @"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",
                            @"标题3":@"自定义字段字段3",
                            @"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",
                            @"标题4":@"自定义4",
                            @"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"
                            };
    
}


// 自定义参数 商品信息相关
- (void)customerGoodAndLeavePageWithParameter:(ZCKitInfo *)uiInfo{
    
    // 商品信息自定义
    if (_isShowGoodsSwitch.on) {
        ZCProductInfo *productInfo = [ZCProductInfo new];
        productInfo.thumbUrl = _goodsImgTF.text;
        productInfo.title = _goodsTitleTF.text;
        productInfo.desc = _goodsSummaryTF.text;
        productInfo.label = _goodTagTF.text;
        productInfo.link = _goodsSendTF.text;
        
        [[NSUserDefaults standardUserDefaults] setObject:productInfo.thumbUrl forKey:@"goods_IMG"];
        [[NSUserDefaults standardUserDefaults] setObject:productInfo.title forKey:@"goods_Title"];
        [[NSUserDefaults standardUserDefaults] setObject:productInfo.desc forKey:@"goods_SENDMGS"];
        [[NSUserDefaults standardUserDefaults] setObject:productInfo.label forKey:@"glabel_Text"];
        [[NSUserDefaults standardUserDefaults] setObject:productInfo.link forKey:@"gPageUrl_Text"];
        uiInfo.productInfo = productInfo;
    }
#warning // 测试环境接口，上线demo去掉不在使用

//        uiInfo.apiHost = @"http://test.sobot.com";

    // 设置电话号和昵称（留言界面的显示）
    uiInfo.isAddNickName = _isAddNickSwitch.on;
    uiInfo.isShowNickName = _isShowNickSwitch.on;
    if(_hostTF.text!=nil){
        uiInfo.apiHost = _hostTF.text;
    }
    //    uiInfo.apiHost = @"http://test.sobot.com";
    
}


// 未读消息数
- (void)customUnReadNumber:(ZCKitInfo *)uiInfo{
    // 未读消息
    _unReadMsgCount.hidden = YES;
    _unReadMsgCount.text = @"0";
    [ZCLibClient getZCLibClient].receivedBlock = ^(id obj,int unRead){
        NSLog(@"当前消息数：%d \n %@",unRead,obj);
        if(unRead>0){
            _unReadMsgCount.hidden = NO;
            _unReadMsgCount.text = [NSString stringWithFormat:@"%d",unRead];
        }else{
            _unReadMsgCount.hidden = YES;
            _unReadMsgCount.text = @"0";
        }
    };
    
}


#pragma mark -- demo中UI界面
- (void)layoutCoustomUI{
    [[ZCLibClient getZCLibClient] setAutoNotification:_isAutoRemindSwitch.on];
    _robotIdTF.keyboardType = UIKeyboardTypeNumberPad;
    _robotUnknowCount.keyboardType = UIKeyboardTypeNumberPad;
    _historyScopeTF.keyboardType = UIKeyboardTypeNumberPad;
    _aidTurn =0;
    _type = 0;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere1:)];
    [self.view addGestureRecognizer:tap];
    
    [_closePushBtn setImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [_closePushBtn addTarget:self action:@selector(btnClosePush:) forControlEvents:UIControlEventTouchUpInside];
    [_openOffLineMsgBtn addTarget:self action:@selector(offLineAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_closeSessionButton addTarget:self action:@selector(buttonCloseSession:) forControlEvents:UIControlEventTouchUpInside];
    _openOffLineMsgBtn.tag = 201;
    
    
    _hostSwitch.tag               = 3;
    _hostSwitch.on                = NO;
    
    _isShowGoodsSwitch.on         = YES;
    _isShowGoodsSwitch.tag        = 4;
    
    _isOpenVideoSwitch.tag        = 5;
    _isOpenVideoSwitch.on         = YES;
    
    _isShowTansferSwitch.tag      = 6;
    _isShowTansferSwitch.on       = YES;
    
    _robotPreferredSwitch.tag     = 7;
    _robotPreferredSwitch.on      = NO;
    
    _onlyServiceSwitch.tag        = 8;
    _onlyServiceSwitch.on         = NO;
    
    _artificialPrioritySwitch.tag = 9;
    _artificialPrioritySwitch.on  = NO;
    
    _onlyRobotSwitch.tag          = 10;
    _onlyRobotSwitch.on           = NO;
    
    _isBackSwitch.on              = YES;
    _isBackSwitch.tag             = 18;
    
    _isCloseSessionWhenBackSwitch.on = NO;
    _isCloseSessionWhenBackSwitch.tag = 40;
    
    _isAutoRemindSwitch.on         = YES;
    _isAutoRemindSwitch.tag        = 19;
    
    _isAidSwitch.on                = NO;
    _isAidSwitch.tag               = 30;
    
    _titleDefaultSwitch.on         = YES;
    _titleDefaultSwitch.tag        = 31;
    
    _titleCustomSwitch.on          = NO;
    _titleCustomSwitch.tag         = 32;
    _titleEnterpriseSwitch.on      = NO;
    _titleEnterpriseSwitch.tag     = 33;
    _titleCustomTF.hidden          = YES;
    
    _isAddNickSwitch.on            = NO;
    titleType = @"0";
    
    [[ZCLibClient getZCLibClient] setAutoNotification:YES];
    
    [_titleDefaultSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_titleCustomSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_titleEnterpriseSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_isAidSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_isAutoRemindSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_hostSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_isShowGoodsSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_isShowTansferSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_isOpenVideoSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_robotPreferredSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_onlyServiceSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_artificialPrioritySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_onlyRobotSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_isBackSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    
    // 未读消息数
    _unReadMsgCount.layer.cornerRadius = 10.0f;
    _unReadMsgCount.layer.masksToBounds = YES;
    _unReadMsgCount.hidden = YES;

    
    // 离线消息数
    _offLineMsgCount.layer.cornerRadius = 10.0f;
    _offLineMsgCount.layer.masksToBounds = YES;
    _offLineMsgCount.hidden = YES;
    
    
    
    NSString *SkillSet_Text=[[NSUserDefaults standardUserDefaults] valueForKey:@"SkillSet_Text"];
    if(SkillSet_Text != nil){
        _groupIdTF.text = SkillSet_Text;
    }else{
        // 设置默认值
    }
    
    NSString *gimg_Text=[[NSUserDefaults standardUserDefaults] valueForKey:@"goods_IMG"];
    if(gimg_Text != nil){
        _goodsImgTF.text = gimg_Text;
    }else{
        // 设置默认值
        _goodsImgTF.text = @"http://gtb.baidu.com/HttpService/get?p=dHlwZT1pbWFnZS9qcGVnJm49dmlzJnQ9YWRpbWcmYz10YjppZyZyPTM2MzI4MTA4MCw0MjcwMDE0NjkAa38";
    }
    NSString *gimg_TitleText=[[NSUserDefaults standardUserDefaults] valueForKey:@"goods_Title"];
    if(gimg_TitleText != nil){
        _goodsTitleTF.text = gimg_TitleText;
    }else{
        // 设置默认值
        _goodsTitleTF.text = @"我是要显示饿标题我是要显示饿标题我是要显示饿标题我是要最多显示三行";
    }
    NSString *gsend_Text=[[NSUserDefaults standardUserDefaults] valueForKey:@"goods_SENDMGS"];
    if(gimg_Text != nil){
        _goodsSendTF.text = gsend_Text;
    }else{
        // 设置默认值
        _goodsSendTF.text = @"摘要描述内容 http://www.baidu.com 你好";
    }
    
    NSString *glabel_Text = [[NSUserDefaults standardUserDefaults] valueForKey:@"glabel_Text"];
    if (glabel_Text !=nil) {
        _goodTagTF.text = glabel_Text;
    }else{
        _goodTagTF.text = @"300元";
    }
    
    NSString *gPageUrl_Text = [[NSUserDefaults standardUserDefaults] valueForKey:@"gPageUrl_Text"];
    if (gPageUrl_Text !=nil) {
        _goodsSummaryTF.text = gPageUrl_Text;
    }else{
        _goodsSummaryTF.text = @"https://api.sobot.com";
    }
    
    
#pragma mark 设置默认APPKEY
    NSString *appKey_Text = [[NSUserDefaults standardUserDefaults] valueForKey:@"appKey_Text"];
       appKey_Text = @"61f0943a972d4de4a93aa70c574869de";
    if (appKey_Text !=nil && ![@"" isEqualToString:appKey_Text]) {
        _appKeyTF.text = appKey_Text;
    }else{
        _appKeyTF.text = @"61f0943a972d4de4a93aa70c574869de";
    }
    
    // 查看存储的值
    NSUserDefaults * userID = [NSUserDefaults standardUserDefaults];
    NSString *userId=[userID valueForKey:@"Pre_Text"];
    if(userId!=nil){
        // 用户ID
        _userIdTF.text=userId;
    }else{
        //  _textField.text=@"03a19a7eb193466ebc683bb40924d5ce";
        
    }
    
    NSLog(@"\nvc=%zd\ndivice=%zd\napp=%zd",self.interfaceOrientation,[[UIDevice currentDevice] orientation],[[UIApplication sharedApplication] statusBarOrientation]);
    if([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown){
        NSLog(@" 竖排");
    }else{
        NSLog(@"横屏");
    }
    
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationMaskPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        NSLog(@"\nvc=%zd\ndivice=%zd\napp=%zd",self.interfaceOrientation,[[UIDevice currentDevice] orientation],[[UIApplication sharedApplication] statusBarOrientation]);
    
    if([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown){
        NSLog(@" 竖排");
    }else{
        NSLog(@"横屏");
    }
}


#pragma mark -- switch事件
-(IBAction)switchValueChanged:(UISwitch *)sender{
    switch (sender.tag) {
        case 2:
            if(sender.on){
                _groupIdTF.hidden = NO;
            }else{
                _groupIdTF.hidden = YES;
            }
            break;
      
        case 4:
            if(sender.on){
                _goodsSummaryTF.hidden = NO;
                _goodTagTF.hidden = NO;
                _goodsSendTF.hidden = NO;
                _goodsTitleTF.hidden = NO;
                _goodsImgTF.hidden = NO;
            }else{
                _goodsSummaryTF.hidden = YES;
                _goodTagTF.hidden = YES;
                _goodsSendTF.hidden = YES;
                _goodsTitleTF.hidden = YES;
                _goodsImgTF.hidden = YES;
            }
            break;
      
        case 6:
            if (sender.on) {
                _robotUnknowCount.hidden = YES;
                //                _unknownCountTextField.hidden = YES;
            }else{
                //                _unknownCountTextField.hidden = NO;
                _robotUnknowCount.hidden = NO;
            }
            break;
        case 7:
            if (sender.on) {
                // 接入方式,1只有机器人,2.仅人工 3.智能客服-机器人优先 4智能客服-人工客服优先
                //                _robotPreferredSwitch.on = YES;
                _onlyServiceSwitch.on = NO;
                _onlyRobotSwitch.on = NO;
                _artificialPrioritySwitch.on = NO;
                _type = 3;
            }else{
                _type = 0;
            }
            break;
        case 8:
            if (sender.on) {
                _robotPreferredSwitch.on = NO;
                //                _onlyServiceSwitch.on = NO;
                _onlyRobotSwitch.on = NO;
                _artificialPrioritySwitch.on = NO;
                _type = 2;
            }else{
                _type = 0;
            }
            break;
        case 9:
            if (sender.on) {
                _robotPreferredSwitch.on = NO;
                _onlyServiceSwitch.on = NO;
                _onlyRobotSwitch.on = NO;
                //                _artificialPrioritySwitch.on = NO;
                _type = 4;
            }else{
                _type = 0;
            }
            break;
        case 10:
            if (sender.on) {
                _robotPreferredSwitch.on = NO;
                _onlyServiceSwitch.on = NO;
                //                _onlyRobotSwitch.on = NO;
                _artificialPrioritySwitch.on = NO;
                _type = 1;
            }else{
                _type = 0;
            }
            break;
        case 19:
            [[ZCLibClient getZCLibClient] setAutoNotification:sender.on];
            break;
        case 30:
            if (sender.on) {
                _aidTurn = 1;
            }else{
                _aidTurn = 0;
            }
            break;
        case 31:
            if (sender.on) {
                _titleEnterpriseSwitch.on = NO;
                _titleCustomSwitch.on  = NO;
                _titleCustomTF.hidden = YES;
                titleType = @"0";
            }else{
                _titleEnterpriseSwitch.on = NO;
                _titleCustomSwitch.on  = NO;
                _titleCustomTF.hidden = YES;
                titleType = @"0";
            }
            break;
        case 32:
            if (sender.on) {
                _titleDefaultSwitch.on = NO;
                _titleCustomTF.hidden = NO;
                _titleEnterpriseSwitch.on = NO;
                titleType = @"2";
            }else{
                _titleDefaultSwitch.on = NO;
                _titleCustomTF.hidden = YES;
                _titleEnterpriseSwitch.on = NO;
                titleType = @"0";
            }
            break;
        case 33:
            if (sender.on) {
                _titleDefaultSwitch.on = NO;
                _titleCustomTF.hidden = YES;
                _titleCustomSwitch.on = NO;
                titleType = @"1";
            }else{
                _titleDefaultSwitch.on = NO;
                _titleCustomTF.hidden = YES;
                _titleCustomSwitch.on = NO;
                titleType = @"0";
            }
            break;
        default:
            break;
    }
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
