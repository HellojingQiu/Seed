//
//  SignInViewController.m
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/7.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfieldCityCode;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSubmit:(id)sender {
    NSLog(@"Submit success!");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mask - TextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *phonenumber = (textField == _textfieldPhoneNumber) ? [textField.text stringByReplacingCharactersInRange:range withString:string] : _textfieldPhoneNumber.text;
    NSString *password = (textField == _textfieldPassword) ? [textField.text stringByReplacingCharactersInRange:range withString:string] : _textfieldPassword.text;
    
    _buttonSubmit.enabled = phonenumber.length>=11 && password.length >=6;
    
    NSUInteger lenghtString = string.length;
    for (int index = 0; index < lenghtString; index++) {
        unichar character = [string characterAtIndex:index];
        if (textField == _textfieldPhoneNumber) {
            //<ore than eleven prohibited input
            if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 11) return NO;
            //range "0-9"
            if (character >= 48 &&character <=57) {
            }else return NO;
        }else if(textField == _textfieldPassword){
            _buttonSubmit.enabled ? (textField.enablesReturnKeyAutomatically = YES) :(textField.enablesReturnKeyAutomatically = NO);
            
            if (character == 32) return NO;
        }
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _textfieldPhoneNumber) {
        [_textfieldPassword becomeFirstResponder];
    }else if (textField == _textfieldPassword){
        if (_textfieldPhoneNumber.text.length >=11 &&_textfieldPassword.text.length >= 6) {
            [self actionSubmit:textField];
        }
    }
    return YES;
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
