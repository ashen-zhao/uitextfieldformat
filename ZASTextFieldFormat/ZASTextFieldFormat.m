//
//  ZASTextFieldFormat.m
//  ZASTextFieldFormat
//
//  Created by ashen on 2018/7/16.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import "ZASTextFieldFormat.h"

@interface ZASTextFieldFormat()<UITextFieldDelegate>
/*
 * 支持的字符串
 * eg: abcde0123456
 * 输入框内只能输入abcde0123456
 */
@property (nonatomic, copy) NSString *charactersInString;
/*
 * 格式显示
 * eg: #### ### ## #
 * 输入框内只能显示 #### ### ## #的格式
 */
@property (nonatomic, copy) NSString *format;
/*
 * 最大输入限制个数
 * eg: 10
 * 输入框内只能输入10个字符
 */
@property (nonatomic, assign) NSInteger maxLimit;
@end

@implementation ZASTextFieldFormat


- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - 设置UITextFiled格式入口

- (void)textFieldWithFormat:(NSString *)format charactersInString:(NSString *)charactersInString maxLimit:(NSInteger)maxLimit {
    self.delegate = self;
    self.format = format;
    self.charactersInString = charactersInString;
    self.maxLimit = maxLimit;
}


#pragma mark - Private Methods
// 生成格式字符串
- (NSString *)makeFormatStringWithText:(NSString *)text {
    
    if (!text.length) {
        return @"";
    }
    
    if (!self.charactersInString.length && !self.format.length) {
        return text;
    }
    
    __block NSString *formatString = self.format;
    if (text.length > 0) {
        [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
            NSRange range = [formatString rangeOfString:@"#"];
            if (range.location != NSNotFound) {
                formatString = [formatString stringByReplacingCharactersInRange:range withString:substring];
            }
        }];
    }
    
    if (formatString.length > 0) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"# "];
        formatString = [formatString stringByTrimmingCharactersInSet:characterSet];
    }
    
    return formatString;
}

// 判断在当前光标处，根据format格式判断是否是空格
- (BOOL)isSpaceInFormatAtPoint:(NSInteger)point {
   
    if (!self.format.length) {
        return NO;
    }
    
    if (point < 0 || point > self.format.length) {
        return NO;
    }
    
    if (self.format.length > point && [self.format characterAtIndex:point] == ' ') {
        return YES;
    }
    return NO;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.charactersInString.length > 0) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:self.charactersInString];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
    }
    
    NSString *text = textField.text;
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (text.length > self.maxLimit) {
        return NO;
    }
    
    if (!self.charactersInString.length && !self.format.length) {
        return YES;
    }
    
    // 获取当前光标的位置
    NSUInteger cursorLocation = [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    // 输入框是否含有内容
    if (!string.length) {
        // 重置光标到首位
        cursorLocation = range.location;
    } else {
        // 判断当前位置在format 格式中是否是空格，如果是，光标向后+1
        if ([self isSpaceInFormatAtPoint:cursorLocation]) {
            cursorLocation ++;
        }
        cursorLocation += string.length;
    }
    
    text = [self makeFormatStringWithText:text];
    
    [textField setText:text];
    [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    
    // 移动光标位置
    UITextPosition *position = [textField positionFromPosition:textField.beginningOfDocument offset:cursorLocation];
    if (position) {
        [textField setSelectedTextRange:[textField textRangeFromPosition:position toPosition:position]];
    }
    
    return NO;
}
@end
