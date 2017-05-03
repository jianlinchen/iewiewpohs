//
//  SetBeiZhuController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/3.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import "SetBeiZhuController.h"

@interface SetBeiZhuController ()

@end

@implementation SetBeiZhuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beiZhuTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:self.beiZhuTextField];
    
//    self.beiZhuTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem=tBarBtnItem;
    
}
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    NSLog(@"+++++++++++++++++++++++%@",lang);
    if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"zh-Hant"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写zh-Hant（繁体中午）
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 10) {
                textField.text = [toBeString substringToIndex:10];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 10) {
            textField.text = [toBeString substringToIndex:10];
        }
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self.beiZhuTextField];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if([string length] == 0) {
//        
//        return YES;
//    }
//    if ([textField isEqual:self.beiZhuTextField]) {
//        if (range.location == 10) {
//            return NO;
//        }
//    }
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSInteger length= textField.text.length;
//    if(length>10)
//    {
//        NSString *memo = [textField.text substringWithRange:NSMakeRange(0, 10)];
//        self.beiZhuTextField.text=memo;
//    }
//}
-(void)backBtnCilck{
    
    [self.beiZhuTextField resignFirstResponder];
    NSLog(@"1231231231231");
    if([self.beiZhuTextField.text isEqualToString:@""]){
    [SVProgressHUD showErrorWithStatus:@"请输入备注名"];
    return;
}
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(1),@"customerId":self.Id,@"remark":self.beiZhuTextField.text};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:setBeiCustomer method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            NSLog(@"完成");
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:self.beiZhuTextField.text ];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        }
    } fail:^(NSString *msg) {
        
    }];
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //开始编辑时触发，文本字段将成为first responder
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.beiZhuTextField resignFirstResponder];
    
    
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

- (IBAction)fineshAction:(id)sender {
    if([self.beiZhuTextField.text isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入备注名"];
        return;
    }
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(1),@"customerId":self.Id,@"remark":self.beiZhuTextField.text};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:setBeiCustomer method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            NSLog(@"完成");
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:self.beiZhuTextField.text ];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popViewControllerAnimated:YES];

        }
        }
    } fail:^(NSString *msg) {
        
    }];
    

    
}
@end
