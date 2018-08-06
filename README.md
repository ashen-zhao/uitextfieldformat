# ZASTextFieldFormat

### 简介
一行代码，设置UITextField的输入格式限制，比如手机号、身份证号、银行卡号格式以及输入字符类型个数的限制等；


### 接口说明
```

/**
 * ZASTextFieldFormatDelegate代理
 *
 */
@property (nonatomic, assign) id<ZASTextFieldFormatDelegate> zasDelegate;

/**
 * 设置浮点类型,只允许输入两位小数的浮点类型（default=NO）
 * 
 */
@property (nonatomic, assign) Boolean isFloat;

/**
 * 设置正则匹配模式（如果设置正则模式，则忽略其他格式限制）
 *
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
```

### 具体使用
使原有UITextField继承自ZASTextFieldFormat，然后调用如何接口即可；

```
[_tfPhone textFieldWithFormat:@"### #### ####" charactersInString:@"0123456789" maxLimit:11];
```
