//
//  16.12 XML编码.swift
//  算法
//
//  Created by Plum on 2021/6/9.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P
 
 16.12XML编码。XML极为长,你找到一种编码方式,可将每个标签对应为预先定义好的整数值,该编码方式的语法如下:
  Element   --> Tag Attributes END Children END
  Attribute --> Tag value
  End      --> 0
  Tag       --> 映射至某个预定义的整数值
  Value     --> 字符串
 例如,下列XML会被转换压缩成下面的字符串(假定对应关系为family->1、 person
 ->2、 firstName->3、 lastName->4、 state->5)
  <family lastMame="Mcdowell" state="CA">
    <person firstName="Gayle">Some Message</person>
  </family>
 变为:
  1 4 Mcdowell 5 CA 2 3 Gayle Some Message 00
 编写代码,打印XML元素编码后的版本(传入Element和 Attribute对象)(提示:
 #465)

 */

struct Interview_16_12 {
    
    
    static func test() {
        
        print("\(self) OVER")
    }
}
