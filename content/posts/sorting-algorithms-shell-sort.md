---
title: "排序算法: 希尔排序（Shell Sort）"
date: 2019-07-30T00:03:00+08:00
draft: true
tags: ["排序算法", "Sorting Algorithm"]
slug: "sorting-algorithms-shell-sort"
---

> Sorting Algorithms : Shell Sort

### 希尔排序的定义（Shell Sort Definition）

[Wikipedia 上对希尔排序（Shell Sort）描述](https://en.wikipedia.org/wiki/Shellsort)：

希尔排序，也称递减增量排序算法，是插入排序的一种更高效的改进版本，是一种原地（[in-place](https://en.wikipedia.org/wiki/In-place_algorithm)）的比较排序。

- 首先对存在间隔的元素进行排序，然后逐渐减小要比较的元素之间的间隙

- 从间隔大的元素开始，这样会比其他简单的比较排序更快地将未排序的元素移动到正确的位置。

<!--more-->

Shell Sort 的时间复杂度取决于采用的间隔序列。

### 算法示例（Example）

1. 以列表中的第一个元素作为已排序子列表，其余元素作为未排序子列表。
	
	取第二个元素赋值给 `key` ，然后比较 `key` 与第一个元素，如果第一个元素大于 `key`，则将 `key` 插入到第一个元素前面。

	![insertion-sort-work-1](/insertion-sort-work-1.png)

2. 取第三个元素并将其与左侧的元素进行比较。将它放在比它小的元素后面。如果没有小于它的元素，则将其放在数组的开头。
	
	![insertion-sort-work-2](/insertion-sort-work-2.png)
	
3. 以此类推，将每个未排序的元素放在正确的位置。 

	![insertion-sort-work-3](/insertion-sort-work-3.png)
	
	![insertion-sort-work-4](/insertion-sort-work-4.png)

### 算法复杂度（Algorithm Complexity）

时间复杂度（Time Complexities）：

- 最坏情况的复杂度：`O(n^2)`

	假设，数组按升序排序，但目的是为了对列表进行降序排序。在这种情况下，那么最坏的情况就会发生。
	
	必须将每个元素与其他元素进行比较，因此，对于每次第 `n` 个元素，进行 `(n - 1)` 次比较，所以总的比较数 为 `n * (n - 1)`，约等于 `n^2`
	
- 最好情况的复杂度：`O(n)`

	当列表已经是有序时，外循环运行 `n` 次，而内循环根本不运行。所以，只有 `n` 个比较。因此，复杂度是线性的。

- 平均情况的复杂度：`O(n^2)`

	当数组的元素是混乱的顺序（既不是升序也不是降序）时，就会发生这种情况。

空间复杂度（Space Complexity）：

- 因为需要一个临时变量 key ，因此空间复杂度为 `O(1)`

稳定性（Stability）：

- 稳定性概念

		如果 a 原本在 b 前面，而 a = b，排序之后 a 仍然在 b 的前面，那么说明该排序是稳定的，反之说明该排序是不稳定的。

- 插入排序是稳定的（Stable）

### 插入排序的应用（Insertion Sort Applications）

插入排序使用于以下的情况：

- 需要排序的列表中的元素数量很少

- 需要排序的列表中，只有少数元素需要排序

### 代码实现（Code and Implementation）

C 语言实现

------

```c
// C program for implementation of shell sort

#include <stdio.h>

// n 为第几个元素，gap 为当前间隔增量
void insert(int arr[], int n, int gap) {
    int key = arr[n];
    int i = n;
    // 如果该组元素中，前几个元素都比 a[i] 大，则执行后移，把比 a[i] 大的都移动到 a[i] 后面
    while (i > 0 && arr[i - gap] > key) {
        arr[i] = arr[i - gap];
        i = i - gap;
        // 当 i - gap 后比 gap 小，说明已经排好序，这时退出循环
        if (i < gap) {
            break;
        }
    }
    arr[i] = key;
}

// n 为列表中元素个数，gap 为当前间隔增量
void insertionSort(int arr[], int n, int gap) {
    int i;
    // 进行插入排序，从每个分组的第 gap 个元素开始，而不是从它的第 1 个元素开始
    for (i = gap; i < n; i++) {
        insert(arr, i, gap);
    }
}

void shellSort(int arr[], int n) {
    int gap = n / 2;
    // 间隔增量 gap 每次变小，直到为 1
    while (gap > 0) {
        // 进行插入排序，从每个分组的第 gap 个元素开始，而不是从它的第 1 个元素开始
        insertionSort(arr, n, gap);
        gap /= 2;
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
    int arr[] = {12, 34, 54, 2, 3};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Array before sorting: \n");
    printArray(arr, n);
    shellSort(arr, n);
    printf("\nArray after sorting: \n");
    printArray(arr, n);
    return 0;
}
```

------

### 参考（References）

1. [Programiz - Insertion Sort Algorithm : https://www.programiz.com/dsa/insertion-sort](https://www.programiz.com/dsa/insertion-sort)

2. [B 站 UP 主 - 正月点灯笼 - [算法教程] 几种经典排序的实现 : https://www.bilibili.com/video/av9830014 ](https://www.bilibili.com/video/av9830014)

3. [Wikipedia - Insertion sort : https://en.wikipedia.org/wiki/Insertion_sort](https://en.wikipedia.org/wiki/Insertion_sort)

