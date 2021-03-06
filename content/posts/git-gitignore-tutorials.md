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

需要被忽略的文件指的是通常是开发工具自动生成的文件或者 build artifacts 的文件，这些文件可以在你的本地库派生出来，是一种非必要提交的文件。

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

### Git 忽略模式（Git Ignore Patterns）

- 被忽略的文件是在 .gitignore 特殊文件中进行跟踪的
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
  3. 问号 `?` 表示匹配单个任意字符
  4. 方括号 `[]` 表示匹配在方括号列表中的任意一个字符（如 `[abc]`，要么匹配  `a`，要么匹配  `b`， 要么匹配 `c`）
  5. 方括号 `[]` 中使用短划线 `-` 分隔两个字符表示匹配这两个字符范围内的任意一个字符（如 `[0-9]`表示匹配 `0` 至 `9` 任意一个字符）

#### 示例

---

|        Pattern         | 匹配示例                                                     | 说明 |
| :--------------------- | :----------------------------------------------------------- | :--- |
|      `**/logs`    | 匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/monday/foo.bar`<br/>&emsp;`build/logs/debug.log` | 在开头使用双星号 `**` 的 Pattern，可匹配 Repository 中任何位置的目录。 |
| <br/>`**/logs/debug.log` | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`build/logs/debug.log`<br/>不匹配 :<br/>&emsp;`logs/build/debug.log` | <br/>在开头使用双星号 `**` 的 Pattern，根据文件的名称和父目录的名称来匹配 Repository 中文件。 |
|         <br/><br/>`*.log`         | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`foo.log`<br/>&emsp;`.log`<br/>&emsp;`logs/debug.log` | <br/>星号 `*` 是一个匹配零个或多个任意字符的通配符。 |
| <br/>`*.log`<br/>`!important.log` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`trace.log`<br/>不匹配 :<br>&emsp;`important.log`<br>&emsp;`logs/important.log` | <br/>就算之前已匹配相应模式的要被忽略的文件，但之后添加感叹号 `!` 会使 `!` 所定义的文件变成无效，不会忽略该文件。需要注意的是如果文件的父目录已经被前面的规则忽略掉了，那么对这个文件用 `!` 是不起作用的）<br/>如场景：我们只需要管理 `/logs/` 目录中的 `debug.log` 文件，该目录其他文件不需要管理，那么该规则应写为<br/>`/logs/*`<br/>`!/logs/debug.log`<br/>注意 `/logs/*` 不能写成 `/logs/`，否则父目录就被前面的规则忽略了，`debug.log` 文件虽然加 `!` 不忽略规则，但也不会生效|
| <br/>`*.log`<br/>`!important/*.log`<br/>`trace.*` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`important/trace.log`<br/>不匹配 :<br/>&emsp;`important/debug.log` | <br/>在不忽略规则之后，再定义忽略规则，将重新忽略任何先前否定的文件。 |
| <br/>`/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`debug.log`<br/>不匹配 :<br/>&emsp;`logs/debug.log` | <br/>设置斜杠 `/` 规则，那么只匹配 Repository 根目录中的文件。 |
| <br/>`debug.log` | <br/>匹配 :<br/>&emsp;`debug.log`<br/>&emsp;`logs/debug.log` | <br/>默认情况下，匹配任何目录中的文件 |
| <br/>`debug?.log` | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debugg.log`<br/>不匹配 :<br/>&emsp;`debug10.log` | <br/>问号 `?` 表示只匹配单个任意字符 |
| <br/>`debug[0-9].log`<br/> | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>不匹配 :<br/>&emsp;`debug10.log` | <br/>方括号 `[]` 中使用短划线 `-` 分隔两个字符，匹配指定范围内的单个字符。 |
| <br/>`debug[01].log`<br/> | <br/>匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>不匹配 :<br/>&emsp;`debug2.log`<br/>&emsp;`debug01.log` | <br/>方括号`[]`匹配在方括号列表中的任意一个字符 |
| <br/>`debug[!01].log` | <br/>匹配 :<br/>&emsp;`debug2.log`<br/>不匹配 :<br/>&emsp;`debug0.log`<br/>&emsp;`debug1.log`<br/>&emsp;`debug01.log` | <br/>感叹号 `!` 可用于匹配除方括号列表之外的任何字符。 |
| <br/>`debug[a-z].log`<br/> | <br/>匹配 :<br/>&emsp;`debuga.log`<br/>&emsp;`debugb.log`<br/>不匹配 :<br/>&emsp;`debug1.log` | <br/>方括号 `[]` 中使用短划线 `-` 分隔两个字符，匹配指定范围内的单个字符。范围可以是数字或字母。 |
| <br/>`logs`<br/> | <br/>匹配 :<br/>&emsp;`logs`<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/latest/foo.bar`<br/>&emsp;`build/logs`<br/>&emsp;`build/logs/debug.log`<br/> | <br/>如果不添加斜杠 `/`，则会匹配文件和具有该名称的目录的内容。在左侧的示例中，将会忽略名为 logs 的目录和文件 |
| <br/>`logs/`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/latest/foo.bar`<br/>&emsp;`build/logs/foo.bar`<br/>&emsp;`build/logs/latest/debug.log`<br/> | <br/>斜杠`/`表示该匹配是目录。将忽略与该名称匹配的存储库中任何目录的全部内容（包括其所有文件和子目录） |
| <br/>`logs/`<br/>`!logs/important.log` | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/important.log`<br/> | <br/>如果文件的父目录已经被前面的规则忽略掉了，那么对这个文件用 `!` 是不起作用的 |
| <br/>`logs/**/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>&emsp;`logs/monday/debug.log`<br/>&emsp;`logs/monday/pm/debug.log` | <br/>双星号 `**` 匹配零个或多个目录。 |
| <br/>`logs/*day/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/monday/debug.log`<br/>&emsp;`logs/tuesday/debug.log`<br/>不匹配 :<br/>&emsp;`logs/latest/debug.log` | <br/>星号 `*` 也可用于目录名称。 |
| <br/>`logs/debug.log`<br/> | <br/>匹配 :<br/>&emsp;`logs/debug.log`<br/>不匹配 :<br/>&emsp;`build/logs/debug.log` | <br/>指定特定目录中的文件的规则与 Repository 根目录相关。（也可以在开头添加一个斜杠 `/logs/debug.log`，但 Git 不会做特殊处理） |

---

### Git 支持的忽略规则（Git Ignore Rules）

- 全局忽略规则（Global Git ignore rules）

	可以通过设置 Git `core.excludesFile` 属性为本地系统上的所有存储库定义全局 Git 忽略模式。

	该文件需要手动创建这个文件。如果不确定将` 全局 gitignore`  文件放在何处，建议放在主目录。

	创建文件后，需要手动修改配置文件 git config 配置其位置
	
```shell
$ touch ~/.gitignore
$ git config --global core.excludesFile ~/.gitignore
```

-  个人本地忽略规则（Personal Git Ignore Rules）

	可以在 `.git/info/exclude` 的特殊文件中为特定 Repository 定义个人忽略模式。
	
	它是没有版本可言，也没有随你的 Repository 分发，因此它适合包含个人本地所需要的模式（Patterns）。
	
	如本地有自定义日志记录设置或在存储库工作目录中生成文件的特殊开发工具，则可以考虑将它们添加到 `.git/info/exclude` 文件中，以防止它们意外地提交到你的 Repository。
	
	注意：该 `.git/info/exclude`文件规则和  `.gitignore` 文件一致。

### 忽略以前提交的文件（Ignoring a Previously Committed File）

如果要忽略过去提交的文件，则需要从 Repository 中删除该文件，然后为其添加 `.gitignore` 规则。`.gitignore` 文件只是忽略没有被 `staged(cached)c` 的文件，对于已经被 `staged(cached) ` 文件，所以添加规则到 `.gitignore` 文件时一定要先从 `staged(cached)` 移除，才可以忽略。

#### 命令如下：

```shell
$ git rm -r --cached .
$ git add .
$ git commit -m 'update .gitignore'
```

注意：

- 在 `git rm` 命令中加上选项 `--cached` 意味着该文件将从 Repository 中删除，被忽略的文件继续保留在工作目录中。

- 可以解决创建 `.gitignore` 文件之前已经将不需要提交的文件 `push` 到 Repository 中去，但又想在 Repository 中去掉这些不需要提交的文件的问题

### 提交已被忽略的文件（Committing An Ignored File）

如果想提交已被 `.gitignore` 忽略一个文件到 Repository，可以使用以下的命令

```shell
$ git add -f debug.log
$ git commit -m "Force adding debug.log"
```

### 调试 .gitignore 文件（Debugging .gitignore Files）

当写了复杂的 `.gitignore` 规则或遍布多个 `.gitignore` 文件的规则，但提交不了想要提交的文件的时候，可能是 `.gitignore` 写得有问题，这时候需要找出来到底哪个规则写错了，这时可以将通过`git check-ignore` 命令加上选项 `-v（或--verbose）` 以确定导致需要提交的文件却被忽略的问题。

```shell
$ git check-ignore -v debug.log
.gitignore:3:*.log debug.log
```

### GitHub 收集的 `.gitignore` 文件的模板(A Collection of Useful .gitignore Templates By GitHub)

GitHub 上有许多已经配置好的 `.gitignore` 文件的模板，我们可以通过参考这些模版来组成自己的 `.gitignore` 文件。

<br/>

[GitHub 收集的 `.gitignore` 文件的模板的地址 : https://github.com/github/gitignore](https://github.com/github/gitignore)

### 参考资料（Reference）

1. [Atlassian - Bitbucket - Git - tutorials ](https://www.atlassian.com/git/tutorials/saving-changes/gitignore)

2. [廖雪峰 - Git教程](https://www.liaoxuefeng.com/wiki/896043488029600)

3. [GitHub 收集的 .gitignore 文件的模板的地址](https://github.com/github/gitignore)