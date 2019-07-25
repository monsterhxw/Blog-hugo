---
title: "学习 Git 系列 : .gitignore 文件"
date: 2019-07-25T17:37:00+08:00
draft: false
tags: ["Git"]
slug: "gitignore-tutorials"
---

> Git 的忽略特殊文件 .gitignore 

### Git 将工作副本中的每个文件视为以下三种情况之一：

- 已跟踪的文件（tracked）

	先前已被暂存或已提交的文件

- 未跟踪的文件（untracked）

	未暂存或者未提交的文件

- 忽略文件（ignored）

	显式告知 Git 要忽略的文件

<!--more-->

### 需要忽略的文件

需要被忽略的文件通常是开发工具自动生成的文件和 build artifacts，这些文件可以在你的本地库派生出来，是一种非必要提交的文件

例如：

- 依赖缓存（Dependency Caches）

    如 `/node_modules` 或者 `/packages`

- 已编译的代码（Compiled Code）

	如 Java 的字节码文件 `.class` ，c 语言编译后生成的对象文件 `.o` 和 Python 编译后的字节码文件 `.pyc`

- 构建输出的目录（Build Output Directories）

	如 `/out`, `/bin` , `/target`

- 在程序运行时生成的文件（Files Generated at Runtime）

	如 `.log`, `.lock`, `.tmp`

- 系统隐藏的文件（Hidden System Files）

	如 `.DS_Store` , `Thumbs.db`

- 开发 IDE 的配置文件（Personal IDE Config Files）

	如 `.idea`, `/workspace.xml`

### Git 忽略规则（Git Ignore Patterns）

- 被忽略的文件是在 .gitignore 的特殊文件中进行跟踪的
- 该文件创建在 Git 工作区的根目录下
- 当需要忽略的新文件时，按照 Git 忽略规则（Git ignore patterns）来编辑 .gitignore 文件，并且进行提交
- .gitignore 文件使用 [globbing patterns](https://linux.die.net/man/7/glob) 来匹配文件名

|        Pattern         | 匹配示例                                                     | 说明 |
| :--------------------- | :----------------------------------------------------------- | :--- |
|      `**/logs`    | 匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/monday/foo.bar`<br/>&emsp;`build/logs/debug.log` |      |
| <br/>`**/logs/debug.log` | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`build/logs/debug.log`<br/>不匹配 :<br/>&emsp;`logs/build/debug.log` |      |
|         <br/><br/>`*.log`         | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`foo.log`<br/>&emsp;`.log`<br/>&emsp;`logs/debug.log` |      |
| <br/>`*.log`<br/>`!important.log` | <br/> |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |
|                        |                                                              |      |

