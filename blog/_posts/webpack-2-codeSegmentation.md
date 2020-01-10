---
date: 2020-01-08
tag: 
  - webpack
  - 前端
author: SpongeBob95

---

# Webpack 学习笔记（二）

## 代码分割

官方：将代码分成多个捆绑包，然后可以按需或并行加载。它可用于实现较小的捆绑包并控制资源负载优先级，如果正确使用，则会对负载时间产生重大影响。

#### 分割原则

一、多界面应用
主业务代码+公共依赖+第三方包+webpack运行代码

二、单界面应用
主业务代码+异步模块+第三方包+webpack运行代码

#### 优点
1、将公共依赖文件提取出来可以只在一个页面中引用，减少文件加载次数

2、将第三方依赖及webpack的运行代码提取出来，可以保证业务代码的纯净。

3、不需要修改的第三方依赖及webpack的运行代码提取出来，可以在浏览器形成缓存，减少加载次数

#### 配置
在optimization中配置，默认只提取引用超过2次的公共依赖代码

当optimization.splitChunks.name为字符串时，可在cacheGroups中配置，将第三方依赖再单独提取出来
（在各项中配置name 提取的文件会以output设置的filename为规则定义文件名）
``` javascript
splitChunks: {
	// true: 提取的文件的文件名与入口文件相关, 配置为一个字符串，则提取的代码都存放一个文件中
	name: 'common',

	// all：对所有的同步代码进行提取
	// initial：对所有的代码（同步/异步）进行提取
	// async：对所有异步代码进行提取
	chunks: 'initial',

	// 设置当代码文件大小大于多少时被提取出去
	minSize: 0,
	// 设置文件名中的分隔符 默认是～
	// automaticNameDelimiter: ".",

	// 设置cacheGroups
	// 可以针对性的指定将某些内容单独提取出来
	// 单页面应用提取时，可仅保留该项配置，提取vendor第三方依赖即可
	cacheGroups: {
		// 可根据需求定义文件提取规则
		// module1: {
		// 	test: /module1/,
		// 	name: 'module1',
		// },

		// 提取第三方依赖为一个文件
		vendor: {
			test: /[\\/]node_modules[\\/]/,
			name: 'vendor',
			// 文件提取的优先级，值越大，提取时当前配置的优先级越高
			// cacheGroups之上的配置的priority值为-10，若要以当前配置为准进行提取，则priority最小配置为-10
			priority: -10,
		},
	},
},
```
提取运行配置文件（runtimeChunk作为optimization的属性，和splitChunks同级）
``` javascript
runtimeChunk: {
	name: 'runtime'
}
```