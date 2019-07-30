---
title: "排序算法: 堆排序（Heap Sort）"
date: 2019-07-31T01:16:00+08:00
draft: true
tags: ["排序算法", "Sorting Algorithm"]
slug: "sorting-algorithms-heap-sort"
---

> Sorting Algorithms : Heap Sort

### 堆排序的定义（Heap Sort Definition）

[Wikipedia 上对堆排序（Heap Sort）描述](https://en.wikipedia.org/wiki/Heapsort)：

堆排序，是一种是原地（[in-place](https://en.wikipedia.org/wiki/In-place_algorithm)）的 [基于比较](https://en.wikipedia.org/wiki/Comparison_sort) 的排序算法，可以被认为是一种改进的 [选择排序](https://en.wikipedia.org/wiki/Selection_sort)，是一种利用  [堆（Head）](https://en.wikipedia.org/wiki/Heap_(data_structure)) 这种数据结构所设计的一种排序算法。

- 把列表（数组）转换成堆

- 通过重复从堆中把根结点和最后一个结点交换，并将根结点值插入到数组中来创建排序数组，把交换后的最后一个结点移出堆，每次删除后都需要更新堆以维持堆的性质

<!--more-->

- 从堆中删除所有结点后，结果就是已排序的列表（数组）


### 算法示例（Example）

1. 排序列表共有  `n` 个元素，取整数 `gap(gap < n)` 作为间隔，将列表分成 `gap` 个子列表，所有距离为 `gap` 的元素放在同一个子列表中。
	
	对每个子列表分别进行插入排序
	
	![heap-sort-work-1](/heap-sort/heap-sort-work-1.png)
	
2. 然后缩小间隔 `gap` ，如取 `gap  = gap / 2`，重复`步骤 1`，划分和排序子列表
	
	![heap-sort-work-2](/heap-sort/heap-sort-work-2.png)
	
3. 直至 `gap = 1` 时，对整个列表进行插入排序
	
	![heap-sort-work-3](/heap-sort/heap-sort-work-3.png)

### 算法复杂度（Algorithm Complexity）

时间复杂度（Time Complexities）：

- 最坏情况的复杂度：小于或等于 `$\displaystyle O(n^{2})$`

	希尔排序的最坏情况时间复杂度总是小于或等于 `$\displaystyle O(n^{2})$`
	
	希尔排序的最坏情况时间复杂度与取间隔序列策略有关
	
- 最好情况的复杂度：`$\displaystyle O\left(n\log^{2}n\right)$`

	当数组已经排序时，每个间隔（或增量）的总比较数等于数组的大小。

- 平均情况的复杂度：`$\displaystyle O\left(n\log^{2}n\right)$`

	希尔排序的平均情况的复杂度与取间隔序列策略有关，在 `$\displaystyle O(n^{1.25})$`附近。

时间复杂度取决于所选的间隔序列。对于所选择的不同增量序列，上述复杂度不同。最佳增量序列未知。

<br/>

空间复杂度（Space Complexity）：

- 因为需要一个临时变量 key ，因此空间复杂度为 `O(1)`

稳定性（Stability）：

- 稳定性概念

		如果 a 原本在 b 前面，而 a = b，排序之后 a 仍然在 b 的前面，那么说明该排序是稳定的，反之说明该排序是不稳定的。

- 堆排序是不稳定的（Unstable)，因为希尔排序算法不检查位于间隔之间的元素。

### 堆排序的应用（Heap Sort Applications）

希尔排序使用于以下的情况：

- 对于调用堆栈是一种开销的行为

- 递归超出限制

- 当值靠近的元素在间隔很远时，插入排序不能很好地执行。 希尔排序是有利于减少关闭元素之间的距离，因此会减少执行的交换次数。

### 代码实现（Code and Implementation）

C 语言实现

------

```c
// C program for implementation of heap sort
#include <stdio.h>

void swap(int arr[], int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

// 堆化，n 代表树多少个结点，i 代表对哪一个结点进行 heapify 操作
void heapify(int tree[], int n, int i) {
    // 递归出口(非必要存在)
    if (i >= n) {
        return;
    }
    // 左孩子的下标值
    int leftChild = 2 * i + 1;
    // 右孩子的下标值
    int rightChild = 2 * i + 2;
    // 先假设最大值的下标值 max 为 i
    int maxPos = i;
    // 比较左孩子值是否大于最大结点值，如果大于就将 leftChild 赋给 max
    if (leftChild < n && tree[leftChild] > tree[maxPos]) {
        maxPos = leftChild;
    }
    // 比较右孩子值是否大于最大结点值，如果大于就将 rightChild 赋给 max
    if (rightChild < n && tree[rightChild] > tree[maxPos]) {
        maxPos = rightChild;
    }
    // 如果最大值的下标值 max 不等于 i，则交换下标 max 与 i 的值
    if (maxPos != i) {
        swap(tree, maxPos, i);
        // 从最大值的下标值 max 位置结点递归
        heapify(tree, n, maxPos);
    }
}

// Build heap (rearrange array)
void buildHeap(int tree[], int n) {
    // 最后一个结点的下标
    int lastNode = n - 1;
    // 最后一个结点的双亲结点的下标
    int lastParentNode = (lastNode - 1) / 2;
    // 从最后一个结点的双亲结点开始从下往上的结点开始 heapify
    int i;
    for (i = lastParentNode; i >= 0; i--) {
        heapify(tree, n, i);
    }
}

// main function to do heap sort
void heapSort(int tree[], int n) {
    // 建立一个堆
    buildHeap(tree, n);
    // 从最后一个结点出发，从下往上的结点开始,将根结点的值放在最后的位置上
    int i;
    for (i = n - 1; i >= 0; i--) {
        // 将根结点交换至最后一个结点
        swap(tree, i, 0);
        //因为将最后一个结点的值与根结点进行了交换，所以需要进行 heapify 一次（参数 i 目的去掉最后一个结点）
        heapify(tree, i, 0);
    }
}

// A utility function to print an array of size n
void printArray(int arr[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int tree[] = {2, 5, 3, 1, 10, 4};
    int n = sizeof(tree) / sizeof(tree[0]);
    printf("Array before sorting: \n");
    printArray(tree, n);

    heapSort(tree, n);
    printf("\nArray after sorting: \n");
    printArray(tree, n);
    return 0;
}
```

------

### 参考（References）

1. [Programiz - Heap sort  Algorithm : https://www.programiz.com/dsa/heap-sort](https://www.programiz.com/dsa/heap-sort)
2. [GeeksForGeeks - Heap sort  : https://www.geeksforgeeks.org/heap-sort/](https://www.geeksforgeeks.org/heap-sort/)
3. [Wikipedia - Heap sort : https://en.wikipedia.org/wiki/Heapsort](https://en.wikipedia.org/wiki/Heapsort)
4. [B 站 UP 主 - 正月点灯笼 - 堆排序(heapsort) : https://www.bilibili.com/video/av47196993](https://www.bilibili.com/video/av47196993)

