VIPER-Swift

一个基于 VIPER 架构 的轻量级实现，通过模块化设计提升代码可维护性。支持动态模块组合和清晰的分层通信机制。

项目概述

本项目提供了一个 VIPER 架构 的 Swift 实现方案，通过 Builder 模式 和 Listener 机制 简化模块化开发。每个模块被拆分为独立的组件（View、Interactor、Presenter、Router、Entity），并通过 Builder 动态组合，实现高内聚、低耦合的设计目标。

核心架构

VIPER 分层说明

层级	说明

V (View)	负责 UI 层（如 UIViewController），通过 Presenter 更新界面。

I (Interactor)	处理业务逻辑和数据操作，是模块的核心逻辑层。

P (Presenter)	桥接 View 和 Interactor，处理数据转换和 UI 逻辑。

E (Entity)	定义模块内部的数据模型（如 Data 类）。

R (Router)	管理导航和依赖注入，负责模块间的跳转和生命周期管理。

L (Listener) 完成两个VIPER之间的数据交互。

提供了Xctemplate模版，支持快速使用。
