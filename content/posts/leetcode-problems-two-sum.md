---
title: "刷 LeetCode 系列 [1] : 两数之和"
date: 2019-06-04T00:10:00+08:00
draft: false
tags: ["LeetCode","Java"]
slug: "leetcode-problems-two-sum"
---

> LeetCode 题目 1 问题 : 两数之和

### 题目描述

给定一个整数数组 `nums` 和一个目标值  `target`，请你在该数组中找出和目标值的那 `两个` 整数，并返回他们的数组下标。

<!--more-->

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

#### 示例 :
```shell
给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9

所以返回 [0, 1]

```

### 题解

1、暴力法 <br/>

使用双重循环遍历每个元素 x ,并查找是否存在一个值与 target - x 相等的目标元素。

```Java
public int[] twoSum(int[] nums, int target) {
	for (int i = 0; i < nums.length; i++) {
		for (int j = i + 1; j < nums.length; j++) {
			if (nums[j] == target - nums[i]) {
				return new int[] {i,j};
			}
		}
	}
	throw new IllegalArgumentException("No two sum solution")
}
```

2、一遍哈希表  <br/>

- `哈希表`的`目的`是通过`空间换取速度`
- 我们可以通过使用哈希表存储已经访问过的元素的`值`和`下标(索引)`
- 然后遍历数组，检查哈希表中是否存在`目标元素`与`当前元素`的`差值`
- 如果哈希表中存在值与差值`一致`，返回`这个值的下标(索引)`与`当前元素的下标(索引)`
- 若哈希表中存在值与差值`不一致`，哈希表存储`值`和`当前元素的下标(索引)`

```Java
public int[] twoSum(int nums,int target) {
	Map<Integer, Integer> map = new HashMap<>();
	for (int i = 0; i < nums.length; i++) {
		int complement = target - nums[i];
		if (map.containsKey(complement)) {
			return new int[] {map.get(complement), i};
		}
		map.put(nums[i], i);
	}
	throw new IllegalArgumentException("No two sum solution")
}
```