//
//  10.7 失踪的整数.swift
//  算法
//
//  Created by Plum on 2021/5/30.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P339
 
 10.7失踪的整数,给定一个输文件,包含4亿个非负整数,请设计一种算法,生成一个不
 包含在该文件中的整数,假定你有1GB内存来完成这项任务

 进阶:如果只有10MB内存可用,该怎么办?假设所有值均不同,且有不超过10亿个
 非负整数。
 (提示:#235 #254 #281)
 */

///  1g二进制能够放下 80亿个bit位

/// 进阶：两步扫描法：先将内存大小分块（也就是数组），数组1表示 0-999的数，数组2表示1000-1999的数，以此类推。但遍历一遍之后，判断每个数组的大小是不是满足1000，若不是，那么说明其中有失踪的整数，然后再次遍历，只寻找其中的数。当然，数组表示的范围要计算一下。
/*
 详情见 P339
 */

/// 再进阶：若更小的内存，那么就需要更多次的扫描
