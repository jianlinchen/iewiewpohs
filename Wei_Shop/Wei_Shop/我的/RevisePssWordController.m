//
//  RevisePssWordController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "RevisePssWordController.h"
#import "RYRsaSign.h"
#import "RSA.h"
@interface RevisePssWordController ()

@end

@implementation RevisePssWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.oneTextField resignFirstResponder];
    [self.twoTextField resignFirstResponder];
    [self.threeTextField resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //开始编辑时触发，文本字段将成为first responder
    
}
//限制输入的格式，超出后textfield 不再显示后面的文字
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *textString = textField.text ;
    
    NSUInteger length = [textString length];
    
    BOOL bChange =YES;
    if (length >= 11)
        bChange = NO;
    
    if (range.length == 1) {
        bChange = YES;
    }
    return bChange;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cirPassWordAction:(id)sender {
  
    if (self.oneTextField.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入当前密码"];
        return;
        
        
    }
    if (self.twoTextField.text==0) {
       [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if (self.threeTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请确认新密码"];
        return;
    }
    if (![self.threeTextField.text  isEqualToString: [self.twoTextField text]]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的新密码不一致。请重新输入"];
        
        return;
    }
    [self cirACtion];
}
-(void)cirACtion{
    NSString *oldPWd= [RYRsaSign RSAEncrypt:self.oneTextField.text key:[[GlobarManager shareInstance] publicKey]];
    NSString *newPWd = [RYRsaSign RSAEncrypt:self.threeTextField.text key:[[GlobarManager shareInstance] publicKey]];
    
    NSDictionary *dic = @{@"account":[GlobarManager shareInstance].userConfig.account,@"oldPassword":oldPWd,@"newPassword":newPWd};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:PassWord method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            
            [Utils alertView:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];

            
        }else{
            [SVProgressHUD showErrorWithStatus:object[@"error"][@"extDesc"]];
//            [self.navigationController popViewControllerAnimated:YES];
          }
        }
    } fail:^(NSString *msg) {
        
    }];

    
}
@end
