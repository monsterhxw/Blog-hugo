---
title: "学习 Git 系列 : .gitignore 文件"
date: 2019-07-25T17:37:00+08:00
draft: false
tags: ["Git"]
slug: "git-gitignore-tutorials"
---

> Git 的忽略特殊文件 .gitignore 

### Git 将工作副本中的每个文件视为以下三种情况

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
- .gitignore 文件使用 [Globbing Patterns](https://linux.die.net/man/7/glob) 规范来匹配文件名

#### .gitignore 文件规则

- 基本规范
  1. 以 `#` 开头的行或者 `空行` 会被 Git 所忽略（`#`  作注释）
  2. 目录或者文件前加 `/` 开头表示 Repository 根目录下的目录或文件
  3. 以斜杠 `/` 结尾表示忽略目录
  4. 以叹号 `!` 表示不忽略某个目录或文件
- [Globbing Patterns](https://linux.die.net/man/7/glob) 规范
  1. 星号 `*` 表示匹配零个或多个任意字符
  2. 双星号 `**` 表示匹配 Repository 中任何位置的目录

---

|        Pattern         | 匹配示例                                                     | 说明 |
| :--------------------- | :----------------------------------------------------------- | :--- |
|      `**/logs`    | 匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/monday/foo.bar`<br/>&emsp;`build/logs/debug.log` | 在开头使用双星号 `**` 的 Pattern，可匹配 Repository 中任何位置的目录。 |
| <br/>`**/logs/debug.log` | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`build/logs/debug.log`<br/>不匹配 :<br/>&emsp;`logs/build/debug.log` | <br/>在开头使用双星号 `**` 的 Pattern，根据文件的名称和父目录的名称来匹配 Repository 中文件。 |
|         <br/><br/>`*.log`         | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`foo.log`<br/>&emsp;`.log`<br/>&emsp;`logs/debug.log` | 星号 `*` 是一个匹配零个或多个任意字符的通配符。 |
| <br/>`*.log`<br/>`!important.log` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`trace.log`<br/>不匹配 :<br>&emsp;`important.log`<br>&emsp;`logs/important.log` |      |
| <br/>`*.log`<br/>`!important/*.log`<br/>`trace.*` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`important/trace.log`<br/>不匹配 :<br/>&emsp;`important/debug.log` |      |
| <br/>`/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`debug.log`<br/>不匹配 :<br/>&emsp;`logs/debug.log` |      |
| <br/>`debug.log` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`logs/debug.log` |      |
| <br/>`debug?.log` | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debugg.log`<br/>不匹配 :<br/>&emsp;`debug10.log` |      |
| <br/>`debug[0-9].log`<br/> | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>不匹配 :<br/>&emsp;`debug10.log` |      |
| <br/>`debug[01].log`<br/> | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>不匹配 :<br/>&emsp;`debug2.log`<br/>&emsp;`debug01.log` |      |
| <br/>`debug[!01].log` | <br/>匹配 :<br/>&emsp;`debug2.log`<br/>不匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>&emsp;`debug01.log` |      |
| <br/>`debug[a-z].log`<br/> | <br/>匹配 :<br/>&emsp;`debuga.log`<br/>&emsp;`debugb.log`<br/>不匹配 :<br/>&emsp;`debug1.log` |      |
| <br/>`logs`<br/> | <br/>匹配 :<br/>&emsp;`logs`<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/latest/foo.bar`<br/>&emsp;`build/logs`<br/>&emsp;`build/logs/debug.log`<br/> |      |
| <br/>`logs/`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/latest/foo.bar`<br/>&emsp;`build/logs/foo.bar`<br/>&emsp;`build/logs/latest/debug.log`<br/> |      |
| <br/>`logs/`<br/>`!logs/important.log` | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/important.log`<br/> |      |
| <br/>`logs/**/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/monday/debug.log`<br/>&emsp;`logs/monday/pm/debug.log` |      |
| <br/>`logs/*day/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/monday/debug.log`<br/>&emsp;`logs/tuesday/debug.log`<br/>不匹配 :<br/>&emsp;`logs/latest/debug.log` |      |
| <br/>`logs/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>不匹配 :<br/>&emsp;`build/logs/debug.log` |      |

---
