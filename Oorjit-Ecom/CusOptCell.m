//
//  CusOptCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 31/10/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CusOptCell.h"
#import "AppDelegate.h"

@implementation CusOptCell
{
    AppDelegate* appDelObj;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelObj=(AppDelegate*)[UIApplication sharedApplication].delegate;
    self.text.clipsToBounds=YES;
    self.text.layer.borderWidth=.5;
    self.text.layer.borderColor=[[UIColor blackColor]CGColor];
    if (self.txtHour.tag==1)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        [datePicker setDate:[NSDate date]];
        datePicker.datePickerMode=UIDatePickerModeTime;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
        [ datePicker setLocale:locale];
        [self.txtHour setInputView:datePicker];
        //[self.txtDay setInputView:datePicker];
        
        UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [toolBar setTintColor:appDelObj.redColor];
        UIBarButtonItem *doneBtn;
        if (appDelObj.isArabic) {
            toolBar.transform = CGAffineTransformMakeScale(-1, 1);
            datePicker.transform = CGAffineTransformMakeScale(-1, 1);
            doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseData:)];
        }
        else
        {
            doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData:)];
        }
        //doneBtn.tag=101;
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        
        [self.txtHour setInputAccessoryView:toolBar];
    }
 
    //[self.txtDay setInputAccessoryView:toolBar];
    /*****date picker*******////
    if (self.txtDay.tag==1)
    {
        UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
        [datePicker1 setDate:[NSDate date]];
        datePicker1.datePickerMode=UIDatePickerModeDate;
        
        [self.txtDay setInputView:datePicker1];
        
        UIToolbar *toolBar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [toolBar1 setTintColor:appDelObj.redColor];
        UIBarButtonItem *doneBtn1;
        if (appDelObj.isArabic) {
            toolBar1.transform = CGAffineTransformMakeScale(-1, 1);
            datePicker1.transform = CGAffineTransformMakeScale(-1, 1);
            doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate1:)];
        }
        else
        {
            doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate1:)];
        }
        //doneBtn.tag=101;
        UIBarButtonItem *space1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar1 setItems:[NSArray arrayWithObjects:space1,doneBtn1, nil]];
        
        [self.txtDay setInputAccessoryView:toolBar1];
    }
   
    
    
}
- (IBAction)chooseDate:(id)sender {
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter3 setDateFormat:@"HH:mm"];
    UIDatePicker *picker;
    picker = (UIDatePicker*)self.txtHour.inputView;
    NSDate *date1 = [dateFormatter3 dateFromString:[NSString stringWithFormat:@"%@",[dateFormatter3 stringFromDate:picker.date]]];
    NSLog(@"date1 : %@", date1);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSLog(@"Current Date: %@", [formatter stringFromDate:date1]);
    
   
    self.txtHour.text =[formatter stringFromDate:date1] ;
    [self.txtHour resignFirstResponder];
}
- (IBAction)chooseDate1:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/YYYY"];
    NSString *dateString;
    UIDatePicker *picker;
    picker = (UIDatePicker*)self.txtDay.inputView;
    dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:picker.date]];
    NSString *str=[NSString stringWithFormat:@"%@",dateString];
    NSArray *arr=[str componentsSeparatedByString:@" "];
    NSString *strnew=[[arr objectAtIndex:0]stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    self.txtDay.text =strnew ;
    [self.txtDay resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.text.textColor == [UIColor lightGrayColor]) {
        self.text.text = @"";
        self.text.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.text.text.length == 0){
        self.text.textColor = [UIColor lightGrayColor];
        self.text.text = @"Textview";
        [self.text resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(self.text.text.length == 0){
            self.text.textColor = [UIColor lightGrayColor];
            self.text.text = @"textview";
            [self.text resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)infoAction:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.INFODelegate informationAbout:(int)btn.tag];
}

- (IBAction)clockAction:(id)sender {
    UIButton *btn=(UIButton*)sender;
    [self.INFODelegate timeSelect:(int)btn.tag];
}

- (IBAction)selectionAction:(id)sender {
    UIButton *btn=(UIButton*)sender;
    [self.INFODelegate varientsSelection:(int)btn.tag];
}

- (IBAction)uploadaction:(id)sender {
    UIButton *btn=(UIButton*)sender;
    [self.INFODelegate uploadFile:(int)btn.tag];
}
@end
