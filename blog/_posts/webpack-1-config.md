---
date: 2020-01-07
tag: 
  - webpack
  - 前端
author: SpongeBob95

---

# Webpack 学习笔记（一）

## 基础配置

#### entry: 入口 
也可以在这里使用babel-polyfill（编译es6的库）

``` javescript
entry: {
	app: ['babel-polyfill', './app.js']
}
```
#### output: 出口
``` javescript
output: {
	path: __dirname + "/dist",
	filename: '[name].bundle.js'
}
```
#### moudule.ruls: 定义loader
由于loader的执行顺序是由下往上，所以在配置时，先使用的loader要配置在下面，比如处理less文件的less-loader要配置在css-loader的后面
``` javascript
module: {
	rules: [{
			test: /\.js$/,
			use: {
				// cnpm install babel-loader @babel/core --save-dev
				loader: 'babel-loader',
				options: {
					// 定义babel应该以什么规范编译 通常使用env env储存了多种规范，包含了es2015,es2016,es2017
					// 由于babel/core有不同的版本，所以要安装不同版本对应的babel-preset
					// babel-core --> babel-preset-env
					// @babel/core --> npm install @babel/preset-env --save-dev
					presets: [
						['@babel/preset-env', {
							target: {
								browsers: ['>1%']
							}
						}]
					]
				}
			},

		}, {
			test: /\.tsx?$/,
			use: 'ts-loader'
		}, {
			// 把css提取为单独的文件
			test: /\.less$/,
			use: extractTextCss.extract({
				// 不提取的时候，使用什么样的配置来处理css
				fallback: {
					// cnpm install style-loader --save-dev
					loader: 'style-loader',
					options: {
						// insertAt: style标签插入在哪一块区域 ('top or 'bottom' 或者{before: '#mydiv'})
						insertAt: 'top',
						// insertInto: 插入指定的dom ('#mydiv')
						// singleton: 是否合并为一个style标签
						singleton: true, 
						// webpack4
						injectType: 'singletonStyleTag'
						// transform: 在浏览器环境下，插入style到页面前，用js对css进行操作
						// 指定一个js文件对css进行修改
						transform: './transform.js'
					},
				},
				// 指需要什么样的loader去编译文件
				use: [{
					// cnpm install css-loader --save-dev
					loader: 'css-loader',
					options: {
						// minimize: 是否压缩css (webpack4 弃用 4之前可用)
						// module: 是否使用css模块化
						// webpack3 👇
						// modules: true,
						// webpack4 👇
						modules: {
							localIdentName: '[path][name]_[local]_[hash:4]'
						},
						// alias: css中的全局别名 (webpack4 弃用 4之前可用)
					},
				}, {
					loader: 'postcss-loader',
					options: {
						// cnpm install postcss postcss-loader autoprefixer postcss-cssnext --save
						// 说明接下来的plugin是给谁使用的
						ident: 'postcss',
						plugins: [
							// postcss 之外的第三方插件，使用前需要安装
							require('autoprefixer')(
								// （推荐）对于有兼容性要求的编译，都需要指定目标, 在package.json里做一个统一的配置👇
								// 或者在目录中新建一个.browserslistrc文件进行配置
								// {
								// 	// webpack4
								// 	"overrideBrowserslist": [
								// 		">1%", "last 2 versions"
								// 	]
								// }
							),
							// 使用下一代css
							require('postcss-cssnext')(),
						]
					}
				}, {
					loader: 'less-loader'
				}]
			})
		}
	]
}	
```
browserslist在package.json中的写法

``` javascript
 "browserslist": [
    "> 1%",
    "last 2 versions"
  ]
```

#### plugin: 定义插件
``` javascript
// 与热更新不兼容，要开发环境下使用热更新，需要在plugins配置中将disable设置为true
const extractTextCss = require('extract-text-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

plugins: [
	new extractTextCss({
		filename: '[name].min.css'
	}),
	new htmlWebpackPlugin({
		filename: 'index.html',
		template: './template-index.html',
		// 压缩html 借助第三方对html进行压缩
		minify: {
			collapseWhitespace: true,
		},
		// 控制是否自动引入资源 默认true自动引入
		inject: true,
		/* 指定要哪个入口文件打包出来的结果
		entry: {
			app: './app.js',
			app2: './app2.js'
		},
		指定为app则打包结果的index.html中只会引入app.js的打包结果
		chunks: ['app'] */
	}),
]
```

记一个方便好用的小插件

这个插件可以删除指定文件夹，文件路径为output.path。所以将path配置为dist目录，可在打包前自动清理上次打包的结果文件。
``` javascript
const {
	CleanWebpackPlugin
} = require('clean-webpack-plugin');
```
