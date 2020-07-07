//
//  String.m
//  LeetCode
//
//  Created by Plum on 2020/5/27.
//  Copyright © 2020 Plum. All rights reserved.
//

#import "StringOperation.h"

@implementation StringOperation


/**
 # 题目:请实现一个函数,把字符串中的每个空格替换成"%20"。例如, 输入“ We are happy.”,则输出“We%20are%20 )happy.”
 
 # 解法分析：
 如果可以自己新创建新的字符串，那么从头开始替换 时间复杂度为O(n)
 如果在原来的字符串上操作，若从头开始替换，那么就需要移动后面的内容，这样的时间复杂度O(n^2);如果从后面开始移动，用两个指针分别p1指向原数组末尾，和增长末尾p2，移动那么复杂度是O(n)
 
 */
+ (void)replaceString:(char *)string size:(NSInteger)size {
    if (string == NULL && strcmp(string, "")) {
        return;
    }
    
    NSInteger originLength = 0;
    NSInteger numberOfSpace = 0;
    NSInteger i = 0;
    while (string[i]) {
        ++originLength;
        if (string[i] == ' ') {
            ++numberOfSpace;
        }
        i++;
    }
    
    if (numberOfSpace == 0) {
        return;
    }
    
//    originLength++;
    NSInteger newLength = originLength + numberOfSpace * 2;
    if (newLength > size) {
        return;
    }
    
    while (originLength >= 0 && originLength < newLength) {
        if (string[originLength] == ' ') {
            string[newLength--] = '0';
            string[newLength--] = '2';
            string[newLength--] = '%';
        } else {
            string[newLength] = string[originLength];
            newLength--;
        }
        originLength--;
    }
}

+ (void)test {
    char p1[100] = "you are beautiful";
    [self replaceString:p1 size:100];
    NSLog(@"%@", [[NSString alloc] initWithCString:p1 encoding:NSUTF8StringEncoding]);
    
    char p2[100] = " you are beautiful";
    [self replaceString:p2 size:100];
    NSLog(@"%@", [[NSString alloc] initWithCString:p2 encoding:NSUTF8StringEncoding]);
    
    char p3[100] = "you  are beautiful";
    [self replaceString:p3 size:100];
    NSLog(@"%@", [[NSString alloc] initWithCString:p3 encoding:NSUTF8StringEncoding]);
    
    char p4[100] = "you are beautiful ";
    [self replaceString:p4 size:100];
    NSLog(@"%@", [[NSString alloc] initWithCString:p4 encoding:NSUTF8StringEncoding]);
    
}


bool match(char* string, char* pattern) {
    if (string == NULL || pattern == NULL) {
        return false;
    }
    return  matchCore(string, pattern);
}

bool matchCore(char* string, char* pattern) {
    if ( *string == '\0' && *pattern == '\0') {
        return true;
    }
    
    if (*string != '\0' && *pattern == '\0') {
        return false;
    }
    
    if (*(pattern + 1) == '*') {
        if (*string == *pattern || (*pattern == '.' && *string != '\0')) {
            return matchCore(string, pattern + 2) || matchCore(string + 1, pattern) || matchCore(string + 1, pattern + 2);
        } else {
            return matchCore(string, pattern + 2);
        }
        
    } else {
        if (*string == *pattern || (*pattern == '.' && *string != '\0')) {
            return matchCore(string + 1, pattern + 1);
        } else {
            return false;
        }
    }
    
}

bool isNumber(char* string) {
    if (string == NULL) {
        return false;
    }
    
    bool numberic = scanInt(&string);
    if (*string == '.') {
        ++string;
        numberic = scanUsignInt(&string) || numberic;
    }
    
    if (*string == 'e' || *string == 'E') {
        ++string;
        numberic = scanInt(&string) && numberic;
    }
    return numberic && *string == '\0';
}

// 之所以char**， 要改变string
bool scanInt(char** string) {
    if (**string == '+' || **string == '-') {
        ++(*string);
    }
    return scanUsignInt(string);
}

bool scanUsignInt(char** string) {
    char *temp = *string;
    while (**string != '\0' && **string <= '9' && **string >= '0') {
        // 注意
        ++(*string);
    }
    return *string - temp > 0;
}

+ (void)testReg {
    assert(match("", "a*") == true);
    assert(match("aaa", "a.a") == true);
    assert(match("aaa", "ab*b*aa") == true);
    NSLog(@"testReg OVER");
}

+ (void)testNumber {
    assert(isNumber(NULL) == false);
    assert(isNumber("") == false);
    assert(isNumber("1") == true);
    assert(isNumber(".2") == true);
    assert(isNumber("-.2") == true);
    assert(isNumber("+1") == true);
    assert(isNumber("1.3") == true);
    assert(isNumber("+10.2e10") == true);
    assert(isNumber("+1.2e-10") == true);
    assert(isNumber("+1.2e-10c") == false);
    
    NSLog(@"testNumber OVER");
}


void printAllString(char *p) {
    if (p == NULL) {
        return;
    }
    printCore(p, p);
}

void printCore(char *str, char *begin) {
    if (*begin == '\0') {
        printf("%s\n", str);
    } else {
        for(char *p = begin; *p != '\0'; p++) {
            // 分别把第一部分的字符和第二部分字符替换
            char temp = *begin;
            *(begin) = *p;
            *(p) = temp;
            
            // 重复操作
            printCore(str, begin + 1);
            
            // 还原
            temp = *begin;
            *begin = *p;
            *p = temp;
        }
    }
}



//--------------去掉重复的全排列的--------------

// 去重的全排列就是从第一个数字起每个数分别与它后面非重复出现的数字交换
bool isCanSwap(char *begin, char *end) {
    for(char *i = begin; i < end; i++) {
        if (*i == *end) {
            return false;
        }
    }
    return true;
}

void printAllStringNoRepeat(char *p) {
    if (p == NULL) {
        return;
    }
    printAllStringNoRepeatCore(p, p);
}

void printAllStringNoRepeatCore(char *str, char *begin) {
    if (*begin == '\0') {
        printf("%s\n", str);
    } else {
        for(char *p = begin; *p != '\0'; p++) {
            
            if (isCanSwap(begin, p)) {
                // 分别把第一部分的字符和第二部分字符替换
                char temp = *begin;
                *(begin) = *p;
                *(p) = temp;
                
                // 重复操作
                printAllStringNoRepeatCore(str, begin + 1);
                
                // 还原
                temp = *begin;
                *begin = *p;
                *p = temp;
            }
        }
    }
}


+ (void)testPrintString {
    char a[] = "abc";
    printAllString(a);
    
    NSLog(@"---------------");
    char b[] = "aba";
    printAllStringNoRepeat(b);
}

@end
