//
//  FeedBackController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "FeedBackController.h"

@interface FeedBackController ()<UITextViewDelegate>

@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(barButton)];
    
    self.navigationItem.rightBarButtonItem =rightButton;
    self.feedTextView.delegate=self;
    self.feedTextView.text=@"请写下您的宝贵意见";
    self.feedTextView.textColor = [UIColor lightGrayColor];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(check) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)check{
    if ([self.feedTextView.text isEqualToString:@"请写下您的宝贵意见"]) {
//        self.fanLabel.text = [NSString stringWithFormat:@"0字/200字"];
    }else{
        //        self.textView.text= [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        //
        //        self.textView.text=[self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //
        //
//        self.fanLabel.text = [NSString stringWithFormat:@"%lu字/200字",(unsigned long)self.feedTextView.text.length];
    }
//    NSString *contentStr =self.feedTextView.text;
//    if(self.feedTextView.text.length > 200) {
//        
//        NSLog(@"%@",[contentStr substringToIndex:200]);
//        
//        self.feedTextView.text = [contentStr substringToIndex:200];
//        [self.feedTextView resignFirstResponder];
//        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"超出最大限制长度"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
//    }
    
}

////隐藏导航栏
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self hideTabBar];
//}


- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
}

- (void)barButton{
    
    if ([self.feedTextView.text isEqualToString:@"请写下您的宝贵意见"] ||self.feedTextView.text.length == 0   ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的意见!"
                                                      delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        
        //        [Utils alertView:@"请输入您的意见!"];
        return;
    }
    if ([[self.feedTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您的意见!"
                                                      delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        
        //        [Utils alertView:@"请输入您的意见!"];
        return;
    }
    
    if (self.feedTextView.text.length > 200) {
        //        [Utils alertView:@"最多不能超过200字!"];
        return;
    }
    
    
    [self feedBackRequest];
    
    
}
-(void)feedBackRequest{
    [self.feedTextView resignFirstResponder];

    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"opinion":self.feedTextView.text};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:StoreDetail method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            [Utils alertView:@"反馈成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            
         }
        }
    } fail:^(NSString *msg) {
        
    }];

}
//下面的代码是防止键盘挡住textview的界面。很重要的，应用到通知以及监听
-(void)viewWillAppear:(BOOL)paramAnimated{
    [self hideTabBar];
    [super viewWillAppear:paramAnimated];
    
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewWillDisappear:(BOOL)paramAnimated{
    
    [super viewWillDisappear:paramAnimated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)handleKeyBoardDidShow:(NSNotification *)paramNotification{
    
    NSValue *keyboardRectAsObject = [[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];/*get the frame of the keyboard*/
    
    CGRect keyboardRect;
    
    [keyboardRectAsObject getValue:&keyboardRect];/*place it in a CGRect*/
    
    self.feedTextView.contentInset = UIEdgeInsetsMake(0.0f,0.0f,  keyboardRect.size.height/4,0.0f);//这句是设置textview离键盘的高度
    
}

-(void)handleKeyboardWillHide:(NSNotification *)paramNotification{
    
    self.feedTextView.contentInset = UIEdgeInsetsZero;/*make the text view as the whole view again*/
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请写下您的宝贵意见"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请写下您的宝贵意见";
        textView.textColor = [UIColor lightGrayColor];
    }
}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    //该判断用于联想输入
//    if (textView.text.length > 200)
//    {
//        textView.text = [textView.text substringToIndex:200];
//    }
//}
//- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
//{
//    
//    NSString *contentStr = textField.text;
//    NSLog(@"%lu   %@",(unsigned long)textField.text.length,contentStr);
//    
//    if([self.feedTextView.text length] + [string length] - range.length > 199) {
//        
//        NSLog(@"%@",[contentStr substringToIndex:200]);
//        
//        self.feedTextView.text = [contentStr substringToIndex:200];
//        [self.feedTextView resignFirstResponder];
//        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"标题超出最大限制长度"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
//        return YES;
//        
//    }
//    return YES;
//}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.feedTextView resignFirstResponder];
    
    
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    //开始编辑时触发，文本字段将成为first responder
//    
//}
//

@end
