# ZASTextFieldFormat

### 简介
设置UITextField的输入格式限制，比如手机号、身份证号、银行卡号格式以及输入字符类型个数的限制等；


### 接口说明
```
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
```

### 具体使用
使原有UITextField继承自ZASTextFieldFormat，然后调用如何接口即可；

```
[_tfPhone textFieldWithFormat:@"### #### ####" charactersInString:@"0123456789" maxLimit:11];
```
