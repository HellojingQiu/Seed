//
//  SignUpViewController.m
//  Seed
//
//  Created by OliHire-HellowJingQiu on 15/5/7.
//  Copyright (c) 2015年 OliHire-JokerV. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()<UITextFieldDelegate>{
    UITableView *_tableViewCityList;
    NSArray *_arrayLsit;
    BOOL _showList;
    CGFloat _heightTable;
    CGFloat _heightFrame;
}
@property (weak, nonatomic) IBOutlet UITextField *textFieldVaild;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCityCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.layer.masksToBounds
//    self.view.layer.cornerRadius
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionSubmit:(id)sender {
    NSLog(@"submit succeess!");
}

#pragma mark - Touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - TextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //Except verification code,when the phone number and password blank, disable the textfield
        NSString * phonenumber = (textField == _textFieldPhoneNumber) ? [_textFieldPhoneNumber.text stringByReplacingCharactersInRange:range withString:string] : _textFieldPhoneNumber.text;
        NSString *password = (textField == _textFieldPassword) ? [_textFieldPassword.text stringByReplacingCharactersInRange:range withString:string] : _textFieldPassword.text;
    NSString *vcode = (textField == _textFieldVaild) ? [_textFieldVaild.text stringByReplacingCharactersInRange:range withString:string] : _textFieldVaild.text;

        _buttonSubmit.enabled = phonenumber.length >=11 && password.length >= 6 && vcode.length >= 4;
    
        NSUInteger lengthOfString =string.length;
        for (int index = 0; index < lengthOfString; index++) {
            unichar charcter = [string characterAtIndex:index];
            //if the textfield is vaildfield ,limit the charcter in range "0-9,a-z,A-Z"
            if (textField == _textFieldVaild) {
                if ((charcter >= 48 && charcter <= 57) || (charcter >= 97 && charcter <= 122) || (charcter >= 65 && charcter <= 90)){
                }else return NO;
                //range "0-9"
            }else if (textField == _textFieldPhoneNumber){
                //More than eleven prohibited input
                if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 11) return NO;
                //range "0-9"
                if ((charcter >=48 && charcter <= 57)) {
                }else return NO;
                //range except whitespace
            }else if (textField == _textFieldPassword){
                _buttonSubmit.enabled ? (textField.enablesReturnKeyAutomatically = YES) :(textField.enablesReturnKeyAutomatically = NO);
                
                if (charcter == 32) return NO;
            }
        }
    
    if (textField == _textFieldVaild) {
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        //Limit the Length
        if (proposedNewLength > 4)return NO;
    }
    
        return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _textFieldVaild) {
        [_textFieldPassword becomeFirstResponder];
        return YES;
    }else if (textField == _textFieldPassword){
        if (_textFieldPhoneNumber.text.length >=11 && _textFieldPassword.text.length >= 6 && _textFieldVaild.text.length >= 4) {
            [self ActionSubmit:textField];
        }
        return YES;
    }
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayLsit count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [_arrayLsit objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
