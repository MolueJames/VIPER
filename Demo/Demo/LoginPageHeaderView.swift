//
//  LoginPageTableViewCell.swift
//  Demo
//
//  Created by James on 2019/12/26.
//  Copyright © 2019 MolueJames. All rights reserved.
//

import Foundation
import Architecture
import UIKit

public class LoginPageHeaderView: UIView, LoginPageViewablePresentable {
    public var listener: LoginPageViewableListenerable?
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        let selector: Selector = #selector(submitButtonClicked)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }()
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        self.listener?.submitButtonClicked()
    }
}

public protocol LoginPageViewableListenerable: class {
    //MARK: 定义一些当前页面需要的业务逻辑, 比如网络请求.
    func submitButtonClicked()
}

public protocol LoginPageViewableInteractable: class {
    //MARK: 用于定义其他的Component需要定义的协议方法
    func postNetworkRequest()
}

public protocol LoginPageViewablePresentable: MolueViewablePresentable {
    //MARK: 定义一些页面需要的方法, 比如刷新页面的显示内容等.
    var listener: LoginPageViewableListenerable? { get set }
}

class LoginPageViewableInteractor: MolueViewableInteractable {
    
    unowned var presenter: LoginPageViewablePresentable
    
    weak var listener: LoginPageViewableInteractable?
    
    required init(presenter: LoginPageViewablePresentable) {
        self.presenter = presenter
        presenter.listener = self
    }
}

extension LoginPageViewableInteractor: LoginPageViewableListenerable {
    
    func submitButtonClicked() {
        self.listener?.postNetworkRequest()
    }
}

public class LoginPageViewableBuilder {
    //MARK: 定义当前的Component的构造方法.
    func build(listener: LoginPageViewableInteractable?) -> LoginPageHeaderView {
        let presenter: LoginPageHeaderView = LoginPageHeaderView()
        let interactor = LoginPageViewableInteractor(presenter: presenter)
        interactor.listener = listener
        return presenter
    }
}
