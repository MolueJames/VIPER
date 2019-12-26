//
//  LoginPageBuilderRouter.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import Architecture

protocol LoginPageRouterInteractable: class {
    var viewRouter: LoginPageViewableRouting? { get set }
    var listener: LoginPageInteractListener? { get set }
}

protocol LoginPageViewControllable: class {
    // 定义一些该页面需要的其他commponent的组件, 比如该页面的childViewController等.
    func doPopBackFromLoginPage()
}

final class LoginPageViewableRouter: MolueViewableRouting {

    unowned var interactor: LoginPageRouterInteractable
    
    unowned var controller: LoginPageViewControllable
    
    @discardableResult
    required init(interactor: LoginPageRouterInteractable, controller: LoginPageViewControllable) {
        self.controller = controller
        self.interactor = interactor
        interactor.viewRouter = self
    }
}

extension LoginPageViewableRouter: LoginPageViewableRouting {
    func popBackFromLoginPage() {
        self.controller.doPopBackFromLoginPage()
    }
}

protocol LoginPageInteractListener: class {
    //用于定义其他的Component需要定义的协议方法
    func loginPageDidSelectedTestNumber(_ number: String)
    var list: [String] {get}
}

protocol LoginPageComponentBuildable: MolueComponentBuildable {
    //定义当前的Component的构造方法.
    func build(listener: LoginPageInteractListener) -> UIViewController
}

class LoginPageComponentBuilder: MolueComponentBuilder, LoginPageComponentBuildable {
    func build(listener: LoginPageInteractListener) -> UIViewController {
        let controller = LoginPageViewController()
        let interactor = LoginPagePageInteractor(presenter: controller)
        LoginPageViewableRouter(interactor: interactor, controller: controller)
        interactor.listener = listener
        return controller
    }
}
