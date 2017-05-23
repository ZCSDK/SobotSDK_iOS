//
//  UserInformationViewController.m
//  SobotKitFrameworkTest
//
//  Created by lizhihui on 16/5/3.
//  Copyright © 2016年 zhichi. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()<UITextFieldDelegate>
{
    CGRect frameDefault;
}
@end

@implementation UserInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesAnyWhere:)];
    [self.view addGestureRecognizer:tap];
    _telTextField.delegate = self;
    _nikeTextField.delegate = self;
    _emailTextField.delegate = self;
    _nameTextField.delegate = self;
    _QQTextField.delegate = self;
    _weiChatTextField.delegate = self;
    _weiBoTextField.delegate = self;
    _sexTextField.delegate = self;
    _birthdayTextField.delegate = self;
    _avatarTextField.delegate = self;
    _sourceURLTextField.delegate = self;
    _sourceTitleTextField.delegate = self;
    _userRemarkTextField.delegate = self;
    frameDefault = self.bgScrollView.frame;
    
    
    // 添加默认值
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user != nil) {
        self.telTextField.text      = [user valueForKey:@"phone"];
        self.QQTextField.text       = [user valueForKey:@"qqNumber"];
        self.sexTextField.text      = [user valueForKey:@"userSex"];
        self.emailTextField.text    = [user valueForKey:@"email"];
        self.nameTextField.text     = [user valueForKey:@"useName"];
        self.nikeTextField.text     = [user valueForKey:@"nickName"];
        self.weiBoTextField.text    = [user valueForKey:@"weiBo"];
        self.weiChatTextField.text  = [user valueForKey:@"weChat"];
        self.birthdayTextField.text = [user valueForKey:@"userBirthday"];
        self.avatarTextField.text   = [user valueForKey:@"avatarUrl"];
        self.sourceTitleTextField.text = [user valueForKey:@"sourceTitle"];
        self.sourceURLTextField.text = [user valueForKey:@"sourceURL"];
        self.userRemarkTextField.text = [user valueForKey:@"userRemark"];
    }else{
        _telTextField.text      = @"12345678901";
        _emailTextField.text    = @"sobot.com";
        _avatarTextField.text   = @"http://image.baidu.com";
        _birthdayTextField.text = @"XXXX年XX月XX日";
        _weiChatTextField.text  = @"1234567";
        _weiBoTextField.text    = @"89076655";
        _nikeTextField.text     = @"火星人";
        _QQTextField.text       = @"123123123";
        _sexTextField.text      = @"男";
        _nameTextField.text     = @"小智";
        _sourceTitleTextField.text = @"接入页面为订单页面";
        _sourceURLTextField.text = @"https://post.com";
    }
    
    
}


- (void)touchesAnyWhere:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.24
                     animations:^{
                         [self.bgScrollView setFrame:frameDefault];
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect newFrame = self.bgScrollView.frame;
    newFrame.origin.y = -(textField.tag - 200)*textField.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgScrollView setFrame:newFrame];
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    CGRect newFrame = self.bgScrollView.frame;
    newFrame.origin.y += (textField.tag-200) * textField.frame.size.height+20;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.bgScrollView setFrame:newFrame];
                     }completion:^(BOOL finished){
                         
                     }];
    
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:_telTextField.text forKey:@"phone"];
    [user setValue:_QQTextField.text forKey:@"qqNumber"];
    [user setValue:_sexTextField.text forKey:@"userSex"];
    [user setValue:_emailTextField.text forKey:@"email"];
    [user setValue:_nameTextField.text forKey:@"useName"];
    [user setValue:_nikeTextField.text forKey:@"nickName"];
    [user setValue:_weiBoTextField.text forKey:@"weiBo"];
    [user setValue:_weiChatTextField.text forKey:@"weChat"];
    [user setValue:_birthdayTextField.text forKey:@"userBirthday"];
    [user setValue:_avatarTextField.text forKey:@"avatarUrl"];
    [user setValue:_sourceURLTextField.text forKey:@"sourceURL"];
    [user setValue:_sourceTitleTextField.text forKey:@"sourceTitle"];
    [user setValue:_userRemarkTextField.text forKey:@"userRemark"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
