//
//  ZASTextFieldFormat.h
//  ZASTextFieldFormat
//
//  Created by ashen on 2018/7/16.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZASTextFieldFormatDelegate <NSObject>
@optional
/**
 *  透传 UITextFieldDelegate
 *  如需在页面对textField的事件后做些独自处理，可实现ZASTextFieldFormatDelegate协议
 *  请不要在页面直接实现UITextFieldDelegate协议，否则会有冲突(ZASTextFieldFormat本身已实现UITextFieldDelegate，而Delegate是一对一模式，无法在一个生命周期内实现多个代理)
 */

- (BOOL)zasTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)zasTextFieldShouldBeginEditing:(UITextField *)textField;

- (void)zasTextFieldDidBeginEditing:(UITextField *)textField;

- (BOOL)zasTextFieldShouldEndEditing:(UITextField *)textField;

- (void)zasTextFieldDidEndEditing:(UITextField *)textField;

- (BOOL)zasTtextFieldShouldClear:(UITextField *)textField;

- (BOOL)zasTextFieldShouldReturn:(UITextField *)textField;

@end

@interface ZASTextFieldFormat : UITextField

/**
 * ZASTextFieldFormatDelegate代理
 *
 */
@property (nonatomic, assign) id<ZASTextFieldFormatDelegate> zasDelegate;

/**
 * 设置浮点类型,只允许输入两位小数的浮点类型（default=NO）
 * 需先调用textFieldWithFormat方法，才可设置
 */
@property (nonatomic, assign) Boolean isFloat;

/**
 * 设置正则匹配模式（如果设置正则模式，则忽略其他格式限制）
 * 需先调用textFieldWithFormat方法，才可设置
 */
@property (nonatomic, copy) NSString * pattern;


/**
 * 设置UITextFiled格式控制的入口 (注：这个入口必须被调用)
 * format=nil或者""则不限制格式, charactersInString=nil或者""则不限制字符, maxLimit=0则不限制个数
 *
 * 示例: 以手机号为例
 * @param format              格式，eg: ### #### ####
 * @param charactersInString  支持输入的字符，eg: 0123456789
 * @param maxLimit            最大输入限制个数，eg: 11
 * 结果输入：159 1234 5678
 */
- (void)textFieldWithFormat:(NSString *)format charactersInString:(NSString *)charactersInString maxLimit:(NSInteger)maxLimit;

@end
