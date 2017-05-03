//
//  PostEmailController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved."
#import "PostEmailController.h"
#import "Client.h"
#import "CustomViewController.h"
#import "SendMessageController.h"

@interface PostEmailController (){
    NSMutableString *memberString;
    NSMutableString *customerIdString;
    NSDictionary *dic;
     NSString *beiZhuStr;
}

@end

@implementation PostEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moveTextView.delegate=self;
    self.messageTextView.delegate=self;
    self.messageTextView.editable=NO;
    [self.moveView setFrame:CGRectMake(0, KScreenHeight-140, KScreenWidth, 50) ];
    [self.view addSubview:self.moveView];
    memberString= [NSMutableString new];
    customerIdString=[NSMutableString new];
    
    
    NSLog(@"（传递到下一个界面的 self.cusArray.count是+  %lu",(unsigned long)self.cusArray.count);
    
     NSLog(@"（传递到下一个界面的 self.allCusArray.count是+  %lu",(unsigned long)self.allCusArray.count );
    
//    if (self.cusArray.count!=self.allCusArray.count) {
        for (int i=0; i<self.cusArray.count; i++) {
            
            Client *meb = self.cusArray[i];
            
            if (meb.remark.length!=0) {
                beiZhuStr=meb.remark;
            }else{
                beiZhuStr=meb.nickName;
            }
            
            [memberString appendString:[NSString stringWithFormat:@"%@,",beiZhuStr]];
            [customerIdString appendString:[NSString stringWithFormat:@"%@,",meb.customerId]];
        }
        NSString  *str=[memberString  substringToIndex:(memberString.length -1)];
        
        NSLog(@"%@",str);
        
        self.messageTextView.text=str;
//    }else{
//        self.messageTextView.text=@"全体成员";
//    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    

}
-(void)keyboardWillShow:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.moveView  setFrame:CGRectMake(0, APP_H-kbSize.height-100, KScreenWidth, 50)];
//    [self.view addSubview:self.moveView];
    
}
- (void)keyboardWillHide:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
     [self.moveView setFrame:CGRectMake(0, KScreenHeight-140, KScreenWidth, 50) ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.moveTextView resignFirstResponder];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //开始编辑时触发，文本字段将成为first responder
    //{"success":false,"error":{"code":"MESSAGE-MERCHANT-0001","desc":"已达上限","extDesc":"发送条数已达本周上限"},"result":null}

    
}

- (IBAction)postAction:(id)sender {
    if(self.moveTextView.text.length==0){
       [Utils alertView:@"请输入信息内容!"];
        
        return;
     }
//    [self.moveView setFrame:CGRectMake(0, 440, 320, 50) ];
    [self.moveView setFrame:CGRectMake(0, KScreenHeight-140, KScreenWidth, 50) ];

    [self.moveTextView resignFirstResponder];
    if (self.cusArray.count==self.allCusArray.count) {
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"content":self.moveTextView.text};
  
    }else{
    
        NSString  *str=[customerIdString  substringToIndex:(customerIdString.length -1)];
        NSLog(@"%@",str);
        
       dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"content":self.moveTextView.text,@"customerIds":str};
    }
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:QunSendMessage method:@"GET" success:^(id object) {
            if (object) {
                if ([[object objectForKey:@"success"]intValue] == 1) {
                [Utils alertView:@"信息已发送"];
                self.moveTextView.text=@"";
                    
                    for(UIViewController *VC in self.navigationController.viewControllers){
                        if([VC isKindOfClass:[SendMessageController class]]){
                            [self.navigationController popToViewController:VC animated:YES];
                            return;
                        }
                    }
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }else{
//                    self.moveTextView.text=@"";
                    NSDictionary *dict=[object objectForKey:@"error"];
                    NSString *yy=[dict objectForKey:@"extDesc"];
                     [Utils alertView:yy];
                 }
            }
        } fail:^(NSString *msg) {
            
        }];
 }
@end
