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
项目结构

深色版本

VIPER/
├── Architecture/          # 核心架构代码（VIPER 模块定义）
│   ├── VIPERModule.swift  # VIPER 模块协议定义
│   ├── VIPERBuilder.swift # Builder 模式基类
│   └── VIPERListener.swift# Listener 通信协议
├── Demo/                  # 示例应用（包含具体模块实现）
│   ├── HomeModule/        # 示例模块（View/Interactor/Presenter/Router/Builder）
│   └── ...                # 其他模块
├── VIPER.xctemplate       # Xcode 模板（可选，用于快速生成 VIPER 模块）
└── README.md
快速开始

1. 克隆仓库

Bash
深色版本

git clone https://github.com/MolueJames/VIPER.git
cd VIPER
2. 运行示例应用

Bash
深色版本

# 打开 Xcode 工程
open VIPER.xcworkspace
3. 创建新模块

步骤 1：定义模块协议

Swift
深色版本

// SomeModuleProtocol.swift
protocol SomeModuleListener: AnyObject {
    func someEventDidTrigger(data: String)
}
步骤 2：实现各组件

Swift
深色版本

// SomeView.swift (View)
class SomeView: UIViewController, SomeViewProtocol {
    func updateUI(data: String) {
        // 更新界面逻辑
    }
}

// SomeInteractor.swift (Interactor)
class SomeInteractor: SomeInteractorInput {
    func fetchData() {
        // 业务逻辑处理
    }
}

// SomePresenter.swift (Presenter)
class SomePresenter: SomePresenterProtocol {
    func transformData(rawData: String) -> String {
        // 数据转换逻辑
        return "Processed: \(rawData)"
    }
}

// SomeRouter.swift (Router)
class SomeRouter: SomeRouterProtocol {
    func navigateToNextModule() {
        // 跳转逻辑
    }
}
步骤 3：使用 Builder 组合模块

Swift
深色版本

// SomeModuleBuilder.swift
class SomeModuleBuilder {
    static func build(listener: SomeModuleListener) -> SomeView {
        let view = SomeView()
        let interactor = SomeInteractor()
        let presenter = SomePresenter()
        let router = SomeRouter()
        
        // 绑定组件
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.view = view
        
        // 设置监听器
        presenter.listener = listener
        
        return view
    }
}
步骤 4：集成到应用中

Swift
深色版本

// 在父模块中调用
let someModule = SomeModuleBuilder.build(listener: self)
router.present(someModule, animated: true)
核心特性

1. 动态模块组合

通过 Builder 模式 动态创建模块，无需静态注入：

Swift
深色版本

// 动态创建模块并返回 View
let moduleView = SomeModuleBuilder.build(listener: self)
2. 模块间通信

通过 Listener 机制 实现事件通知：

Swift
深色版本

// 子模块触发事件
presenter.listener?.someEventDidTrigger(data: "Hello VIPER!")

// 父模块监听事件
extension ParentModule: SomeModuleListener {
    func someEventDidTrigger(data: String) {
        print("Received event: \(data)")
    }
}
注意事项

文档与示例:
当前 README 和代码示例较为基础，建议直接参考 Demo 目录中的实现。
推荐结合 VIPER-Swift 的文档补充理解。
社区支持:
本仓库目前 stars 较少，建议结合其他 VIPER 资源（如官方文档）使用。
性能优化:
动态组合模块可能增加运行时开销，建议在关键路径上优化代码。
贡献指南

Fork 本仓库并提交 Pull Request。
遵循代码风格和模块化规范。
新增功能需附带单元测试（如适用）。
许可证

本项目采用 MIT License，详情见 LICENSE 文件。
