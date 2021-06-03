//
//  13.5 TreeMap、HashMap、LinkedHashMap.swift
//  算法
//
//  Created by Plum on 2021/6/3.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P366
 
 13.5Treemap、Hashmap、 Linkedhashmap。解释一下 TreeMap、 HashMap、 LinkedHashMap者的不同之处。举例说明各自最适合的情况。
 
 三者都提供了key->value(键值对)的映射和遍历key的迭代器。这些类中最大的区别就
 是给予的时间保证和key的顺序。
 
 1.Hashmap提供了O(1)的查找和插入。如果你要遍历key时,要清楚key其实是无序的。它是用节点为链表的数组实现的。
 
 2.Treemap提供了O(logN)的查找和插入。但key是有序的,如果你想要按顺序遍历key,那么它刚好满足。这也意味着key必须实现了 comparable接口 Treemap是用红黑树实现的。
 
 3.Linkedhashmap提供了O(1)的查找和插入。ey是按照插入顺序排序的。它是用双向链表桶实现的。
 */
