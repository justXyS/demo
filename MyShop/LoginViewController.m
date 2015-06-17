//
//  LoginViewController.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "LoginService.h"
#import "MyMD5.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic,strong) LoginService *loginService;
@property (nonatomic,assign) BOOL keyboardVisible;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.text = self.loginname;

}

- (IBAction)login:(id)sender {
    [SVProgressHUD showWithStatus:@"加载中.."];
    [self.loginService loginWithLoginName:self.username.text password:[MyMD5 md5:self.password.text] viewController:self];
}

-(IBAction)regisetOver:(UIStoryboardSegue *)sender{
    if([sender.sourceViewController isKindOfClass:[RegistViewController class]]){
       RegistViewController *reg = (RegistViewController *)sender.sourceViewController;
        self.username.text = reg.username.text;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:animated];
}

-(void)keyboardDidShow:(NSNotification *)notification{
//    if (self.keyboardVisible){
//        CGRect keyFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        CGRect curFrame = self.scrollView.frame;
//        curFrame.size.height += keyFrame.size.height;
//        self.scrollView.frame = curFrame;
//        CGRect frame = self.btn.frame;
//        [self.scrollView scrollRectToVisible:frame animated:YES];
//    }else{
        CGRect keyFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect curFrame = self.scrollView.frame;
        curFrame.size.height -= keyFrame.size.height;
        NSLog(@"curFrame.size.height:%f",curFrame.size.height);
        //self.scrollView.frame = curFrame;
    self.keyboardHeight.constant = keyFrame.size.height;
        CGRect frame = self.btn.frame;
        [self.scrollView scrollRectToVisible:frame animated:YES];
        self.keyboardVisible = YES;
   // }
}

-(void)keyboardDidHide:(NSNotification *)notification{
    CGRect keyFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect curFrame = self.scrollView.frame;
    curFrame.size.height += keyFrame.size.height;
    NSLog(@"curFrame.size.height");
    //self.scrollView.frame = curFrame;
    self.keyboardHeight.constant = 0;
    self.keyboardVisible = NO;
}


-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [super viewWillDisappear:animated];
}

- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

-(LoginService *)loginService{
    if(!_loginService){
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

@end
