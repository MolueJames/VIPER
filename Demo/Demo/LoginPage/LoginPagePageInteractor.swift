//
//  LoginPagePageInteractor.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import Architecture

protocol LoginPageViewableRouting: class {
    // 定义一些页面跳转的方法, 比如Push, Presenter等.
    func popBackFromLoginPage()
}

protocol LoginPagePagePresentable: MolueInteractorPresentable {
    var listener: LoginPagePresentableListener? { get set }
    // 定义一些页面需要的方法, 比如刷新页面的显示内容等.
}

final class LoginPagePageInteractor: MoluePresenterInteractable {
    
    unowned var presenter: LoginPagePagePresentable
    
    var viewRouter: LoginPageViewableRouting?
    
    weak var listener: LoginPageInteractListener?
    
    var list: [String]?
    
    required init(presenter: LoginPagePagePresentable) {
        self.presenter = presenter
        presenter.listener = self
    }
    
    func viewControllerDidLoad() {
        guard let listener = self.listener else {return}
        self.list = listener.list
    }
}

extension LoginPagePageInteractor: LoginPageRouterInteractable {
    
}

extension LoginPagePageInteractor: LoginPagePresentableListener {
    func postNetworkRequest() {
        
    }

    func didSelectedTestNumber(_ number: String) {
        guard let listener = self.listener, let router = self.viewRouter else {return}
        listener.loginPageDidSelectedTestNumber(number)
        router.popBackFromLoginPage()
    }
}
