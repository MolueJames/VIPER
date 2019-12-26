//
//  HomePagePageInteractor.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import Architecture

protocol HomePageViewableRouting: class {
    // 定义一些页面跳转的方法, 比如Push, Presenter等.
    func pushToLoginPage()
}

protocol HomePagePagePresentable: MolueInteractorPresentable {
    var listener: HomePagePresentableListener? { get set }
    // 定义一些页面需要的方法, 比如刷新页面的显示内容等.
    func showLoginPageTestNumber(_ number: String)
}

final class HomePagePageInteractor: MoluePresenterInteractable {
    
    unowned var presenter: HomePagePagePresentable
    
    var viewRouter: HomePageViewableRouting?
    
    weak var listener: HomePageInteractListener?
    
    required init(presenter: HomePagePagePresentable) {
        self.presenter = presenter
        presenter.listener = self
    }
}

extension HomePagePageInteractor: HomePageRouterInteractable {
    var list: [String] {
        return ["1", "2", "3", "4", "5"]
    }
    
    func loginPageDidSelectedTestNumber(_ number: String) {
        self.presenter.showLoginPageTestNumber(number)
    }
}

extension HomePagePageInteractor: HomePagePresentableListener {
    func jumpToLoginPage() {
        guard let router = self.viewRouter else {return}
        router.pushToLoginPage()
    }
}
