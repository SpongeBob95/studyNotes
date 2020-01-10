---
date: 2020-01-09
tag: 
  - webpack
  - 前端
author: SpongeBob95

---

# Webpack 学习笔记（三）

## sourcemap
webpack的代码映射，在于解决开发代码与实际运行代码不一致时，debugger能够定位到原始开发代码

#### 配置方法👇
``` javascript
devtool: 'eval-source-map',
```

#### 参数概览

开发模式					 |		特点								|		适用情况       
-------------------------|--------------------------------------|--------------------
eval 					 | 构建最快，只能定位到打包后的代码  			|	无需source-map     
eval-source-map		 	 | 构建较快，生成一个DataUrl形式sourcemap	|	需要简单的调试       
cheap-eval-source-map	 | 构建快，重新构建慢，定位到转换后的代码		|	较为详细的调试       
cheap-module-source-map  | 构建慢，重构快，能定位到原始代码			|	开发过程中一般用这个  


生产模式					|		特点										|		适用情况       
------------------------|-----------------------------------------------|--------------------
source-map				|	构建和重构都很慢，能定位到原始代码				|	一般用于上线后    
hidden-source-map		|	构建和重构都很慢，能定位到原始代码，但不追加注释	|	一般不使用         
nosource-source-map		|	构建和重构都很慢，不能定位到原始代码				|	一般不使用         
	 
## 其他常用配置

热更新
``` javascript
hot: true,
```
仅使用热更新 不使用live reloading （不刷新网页更新）
``` javascript
hotOnly: true,
```
错误遮罩 true：将错误显示在浏览器，false：错误显示在console
``` javascript
overlay: true
```
开启代理接口 解决跨域问题
``` javascript
proxy: {
	// 转发规则：示例：碰到以‘/’开头的地址，进行代理转发 
	'/': {
		// 请求转发的目标地址
		target: '',
		// 改变请求的origin的作用，一般设置为true
		changeOrigin: true,
		// 当接口名非常长时，可通过pathRewrite进行简化
		pathRewrite: {

		},
		// 在要被代理的请求中添加的请求头
		headers: {

		}
	}
}
```
