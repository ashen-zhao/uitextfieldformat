//
//  ZASTextFieldFormat.h
//  ZASTextFieldFormat
//
//  Created by ashen on 2018/7/16.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZASTextFieldFormat : UITextField

/**
 * 设置UITextFiled格式控制的入口
 *
 * 示例: 以手机号为例
 * @param format              格式，eg: ### #### ####
 * @param charactersInString  支持输入的字符，eg: 0123456789
 * @param maxLimit            最大输入限制个数，eg: 11
 * 结果输入：159 1234 5678
 */
- (void)textFieldWithFormat:(NSString *)format charactersInString:(NSString *)charactersInString maxLimit:(NSInteger)maxLimit;

@end
