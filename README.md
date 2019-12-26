# VIPER

## 本Demo是VIPER在swift语言上的简单实现

	V: View
	I: Interactor
	P: Presenter
	E: Entity
	R: Router
  
还是参考RIBs使用了Builder去组合VIPER中的各个模块, 同时也使用Listener去负责两个VIPER直接的数据和事件的交互. 
大部分的设计思路都是参考Uber的RIBs的,只是将RIBs的静态注入的方式换成可以支持动态加载的方式, 去除了Component部分.简化了开发者的入门门槛.
