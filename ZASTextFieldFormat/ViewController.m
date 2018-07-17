//
//  ViewController.m
//  ZASTextField
//
//  Created by ashen on 2018/7/16.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import "ViewController.h"
#import "ZASTextFieldFormat.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZASTextFieldFormat *tfPhone;
@property (weak, nonatomic) IBOutlet ZASTextFieldFormat *tfBankCard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tfPhone textFieldWithFormat:@"### #### ####" charactersInString:@"0123456789" maxLimit:11];
    [_tfBankCard textFieldWithFormat:@"#### #### #### #### ###" charactersInString:@"0123456789" maxLimit:19];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
