//
//  File.swift
//  算法
//
//  Created by Plum on 2021/6/3.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P350
 
 11.1找错。找出以下代码中的错误(可能不止一处)
 
 unsigned int i;
 for(i=100;i>=0;--i)
 printf("%d\n", i);
 
 (提示:#257,#299,#362)

 */

/**
 * 答案
 * 1. unsigned int 是 >0 的，因此会无限循环
 * 2. %d，改成 %u
 */
