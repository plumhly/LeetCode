//
//  Topic58.m
//  LeetCode
//
//  Created by Plum on 2020/7/6.
//  Copyright © 2020 Plum. All rights reserved.
//

#import "Topic58.h"

@implementation Topic58

// topic1
/*
 题目一:翻转单词顺序。
 
 输入一个英文句子,翻转句子中单词的顺序,但单词内字符的顺序不变。为简单起见,标点符号和普通字母一样处理。例如输入字符串"i am a student.",则输出" 'student. a am I`
 
 分析：
 以跟面试官解释清楚解题思路:第一步翻转句子中所有的字符。比如翻转I am a student."中所有的字符得到" tneduts a ma I'",此时不但翻转了句子中单词的顺序,连单词内的字符顺序也被翻转了。第二步再翻转每个单词中字符的顺序,就得到了" student.aamT"。这正是符合题目要求的输出。
 */
char* reverseSentence(char *data) {
    if (data == NULL) {
        return NULL;
    }
    
    char *begin = data;
    char *end = data;
    while (*end != '\0') {
        end ++;
    }
    end--;
    
    // 翻转整个句子
    reverse(begin, end);
    
    // 翻转字符
    begin = end = data;
    while (*end != '\0') {
        if (*begin == ' ') {
            begin++;
            end++;
        } else if (*end == ' ' || *end == '\0') {
            reverse(begin, --end);
            end++;
            begin = end;
        } else {
            end++;
        }
    }
    return data;
}

void reverse(char *begin, char *end) {
    while (begin < end) {
        char temp = *begin;
        *begin = *end;
        *end = temp;
        begin++;
        end--;
    }
}


// Topic2
/*
 题目二:左旋转字符串。
 
 P286
 
 字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义ー个函数实现字符串左旋转操作的功能。比如,输入字符串abcdefg'"和数字2,该函数将返回左旋转两位得到的结果" cdefgab"。
 
 分析：
 以" abcdefg"为例,我们可以把它分为两部分。由于想把它的前两个字符移到后面,我们就把前两个字符分到第一部分,把后面的所有字符分到第二部分。我们先分別翻转这两部分,于是就得到" bagfedc"。接下来翻转整个字符串,得到的" cdefgab"刚好就是把原始字符串左旋转两位的结果。
 通过前面的分析,我们发现只需要调用3次前面的 Reverse函数就可以实现字符串的左旋转功能。参考代码如下:
 */
char *leftRotate(char *str, int n) {
    if (str != NULL) {
        unsigned long length = strlen(str);
        char *firstStart = str;
        char *firstEnd = str + n - 1;
        char *secondStart = str + n;
        char *secondEnd = str + length - 1;
        
        reverse(firstStart, firstEnd);
        reverse(secondStart, secondEnd);
        reverse(firstStart, secondEnd);
    }
    
    return str;
}

+ (void)test {
    //topic1
    char s[] = "i am a student.";
    char *result1 = reverseSentence(s);
    assert(strcmp(result1, "student. a am i") == 0);
    
    char b[] = "abcdef";
    char *reslut2 = leftRotate(b, 2);
    assert(strcmp(reslut2, "cdefab") == 0);
    
    NSLog(@"Topic58 Topic1 OVER");
}

@end
