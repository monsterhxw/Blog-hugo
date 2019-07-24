---
title: "排序算法: 冒泡排序（Bubble Sort）"
date: 2019-07-24T00:11:07+08:00
draft: false
tags: ["排序算法", "Sorting Algorithm"]
slug: "sorting-algorithms-bubble-sort"
---

> Sorting Algorithms : Bubble Sort

### 冒泡排序的定义（Definition）

[Wikipedia 上对冒泡排序（Bubble Sort）描述](https://zh.wikipedia.org/wiki/%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F)：

它一种简单的排序算法

- 通过重复地走访要排序的数列，一次比较两个元素

- 如果两个元素顺序错误，则进行交换

- 重复地进行走访数列直到没有再需要交换，说明该数列已经排序完成。

<!--more-->

这个算法的名字由来是因为越小的元素会经由交换慢慢"浮"到数列的顶端。

### 算法思路示例（Example）

- 从第 0 个索引开始，比较第 1 个和第 2 个元素。如果第 1 个元素大于第 2 个元素，则交换它们。

- 继续比较第 2 个和第 3 个元素。如果它们反序则交换它们。

- 重复上述过程续到最后一个元素。

![bubble-sort-work-1](/bubble-sort-work-1.png)

- 对于剩余的迭代，将执行相同的过程。每次迭代之后，未排序元素中最大的元素放在最后。

- 在每个迭代中，一直比较到最后一个还未排序的元素。

- 当所有未排序的元素被放置在正确的位置时，数组排序完成。

![bubble-sort-work-2](/bubble-sort-work-2.png)

![bubble-sort-work-3](/bubble-sort-work-3.png)

![bubble-sort-work-4](/bubble-sort-work-4.png)

### 算法复杂度（Algorithm Complexity）

冒泡排序是最简单的排序算法之一，算法是采用 `2` 个循环。

------

| Pass | Number of Comparisons |
| ---- | --------------------- |
| 1st  | (n - 1)               |
| 2nd  | (n - 2)               |
| 3rd  | (n - 3)               |
| ...  | ...                   |
| last | 1                     |

------

总的比较次数：(n - 1) + (n - 2) + (n - 3) + ... + 1 = n(n - 1) / 2 接近等于 n^2，因此复杂度为 `O(n^2)`

同时我们可以通过简单地观察循环次数来分析复杂性，因为算法使用了 2 个循环，因此复杂度为 `O(n * n )` =` O(n^2)`

<br/>

时间复杂度（Time Complexities）：

- 最坏情况的复杂度：`O(n^2)`

	如果我们想按升序排序数组，但数组已经是按照降序排列好的，那么最坏的情况就会发生。
	
- 最好情况的复杂度：`O(n)`

	如果数组已经排序，那么就数组不需要排序。

- 平均情况的复杂度：`O(n^2)`

	当数组的元素是混乱的顺序（既不是升序也不是降序）时，就会发生这种情况。

空间复杂度（Space Complexity）：

- 因为需要一个临时变量 temp 用于交换，因此空间复杂度为 `O(1)`

- 在优化算法（下面会进行介绍）中，增加了标记（哨兵）变量 `swapped`，因此空间复杂度为 `O(2)`

稳定性（Stability）：

- 稳定性概念

		如果 a 原本在 b 前面，而 a = b，排序之后 a 仍然在 b 的前面，那么说明该排序是稳定的，反之说明该排序是不稳定的。

- 冒泡排序是稳定的（Stable）

### 冒泡排序的应用（Bubble Sort Applications）

冒泡排序使用于以下的情况：

- 对于算法的复杂度并不重视。

- 需要最少行的代码

### 代码实现（Code Implementation）

`C 语言实现`

```c
#include <stdio.h>

// 冒泡
void bubble(int arr[], int n) {
    int i;
    int temp;
    // 一直比较到最后一个还未排序的元素,i 是从前往后循环
    for (i = 0; i < n - 1; i++) {
        // 前一个大于后一个，则交换
        if (arr[i] > arr[i + 1]) {
            temp = arr[i];
            arr[i] = arr[i + 1];
            arr[i + 1] = temp;
        }
    }
}

// 冒泡排序
void bubbleSort(int arr[], int n) {
    int i;
    // 从第 n - 1 次到第 1 次冒泡
    for (i = n; i >= 1; i--) {
        bubble(arr, i);
    }
}

// Function to print an array
void printArray(int arr[], int size) {
    int i;
    for (i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

// Driver program to test above functions
int main() {
    int arr[] = {-2, 45, 0, 11, -9};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Array before sorting: \n");
    printArray(arr, n);
    bubbleSort(arr, n);
    printf("\nArray after sorting: \n");
    printArray(arr, n);
    return 0;
}
```

---

### 冒泡排序的优化（Optimized Bubble Sort）

- 在上面的代码中，即使数组已经完成排序，也会继续剩余的迭代然后进行元素比较，导致增加了执行时间。

- 所以可以通过引入标记（哨兵）变量  `swapped`  来优化代码。在每次迭代之后，如果没有发生交换（即 `swapped` 为 `FALSE`），说明了此数列已经是有序的，则不需要执行进一步的循环。

优化冒泡排序算法代码：

```c
#include <stdio.h>

// Optimized bubble sort in C
void bubbleSort(int arr[], int n) {
    int i, j, temp;
    // The variable "swapped" is introduced for optimization.
    int swapped = 1;
    // 外循环规定了排序次数，从第 1 次到第 n - 1 次
    for (i = 0; i < n - 1 && swapped; i++) {
        swapped = 0;
        // 内循环规定了剩余未排序元素,j 是从前往后循环
        for (j = 0; j < n - i - 1; j++) {
            // 前一个大于后一个，则交换
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = 1;
            }
        }
    }
}

// Function to print an array
void printArray(int arr[], int size) {
    int i;
    for (i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

// Driver program to test above functions
int main() {
    int arr[] = {-2, 45, 0, 11, -9};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Array before sorting: \n");
    printArray(arr, n);
    bubbleSort(arr, n);
    printf("\nArray after sorting: \n");
    printArray(arr, n);
    return 0;
}
```

---

### 参考（References）

[Programiz - Bubble Sort Algorithm : https://www.programiz.com/dsa/bubble-sort](https://www.programiz.com/dsa/bubble-sort)

[GeeksforGeeks - Bubble Sort : https://www.geeksforgeeks.org/bubble-sort/](https://www.geeksforgeeks.org/bubble-sort/)

[B 站 UP 主 - 正月点灯笼 - [算法教程] 几种经典排序的实现 : https://www.bilibili.com/video/av9830014 ](https://www.bilibili.com/video/av9830014)

[Wikipedia - 冒泡排序 : https://en.wikipedia.org/wiki/Bubble_sort](https://en.wikipedia.org/wiki/Bubble_sort)