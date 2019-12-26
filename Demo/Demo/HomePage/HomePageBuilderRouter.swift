//
//  HomePageBuilderRouter.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import Architecture

protocol HomePageRouterInteractable: LoginPageInteractListener {
    var viewRouter: HomePageViewableRouting? { get set }
    var listener: HomePageInteractListener? { get set }
}

protocol HomePageViewControllable: class {
    // 定义一些该页面需要的其他commponent的组件, 比如该页面的childViewController等.
    func pushToTargetViewController(_ controller: UIViewController)
}

final class HomePageViewableRouter: MolueViewableRouting {
    
    unowned var interactor: HomePageRouterInteractable
    
    unowned var controller: HomePageViewControllable
    
    @discardableResult
    required init(interactor: HomePageRouterInteractable, controller: HomePageViewControllable) {
        self.controller = controller
        self.interactor = interactor
        interactor.viewRouter = self
    }
}

extension HomePageViewableRouter: HomePageViewableRouting {
    func pushToLoginPage() {
        let target = LoginPageComponentBuilder().build(listener: self.interactor)
        self.controller.pushToTargetViewController(target)
    }
}

protocol HomePageInteractListener: class {
    //用于定义其他的Component需要定义的协议方法
}

protocol HomePageComponentBuildable: MolueComponentBuildable {
    //定义当前的Component的构造方法.
    func build(listener: HomePageInteractListener) -> UIViewController
    
    func build() -> UIViewController
}

class HomePageComponentBuilder: MolueComponentBuilder, HomePageComponentBuildable {
    func build(listener: HomePageInteractListener) -> UIViewController {
        let controller = HomePageViewController()
        let interactor = HomePagePageInteractor(presenter: controller)
        HomePageViewableRouter(interactor: interactor, controller: controller)
        interactor.listener = listener
        return controller
    }
    
    func build() -> UIViewController {
        let controller = HomePageViewController()
        let interactor = HomePagePageInteractor(presenter: controller)
        HomePageViewableRouter(interactor: interactor, controller: controller)
        return controller
    }
}
