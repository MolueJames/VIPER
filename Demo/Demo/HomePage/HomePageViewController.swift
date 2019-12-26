//
//  HomePageViewController.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import UIKit

protocol HomePagePresentableListener: class {
    // 定义一些当前页面需要的业务逻辑, 比如网络请求.
    func jumpToLoginPage()
}

protocol HomePageViewElementsLayout where Self: HomePageViewController {
    var button: UIButton! {get}
    var label: UILabel! {get}
    func doViewControllerLayout()
}

extension HomePageViewElementsLayout {
    func doViewControllerLayout() {
        self.button.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        self.button.center = self.view.center
        
        self.label.frame = CGRect(x: 30, y: 100, width: self.view.frame.width - 60, height: 45)
    }
}

final class HomePageViewController: UIViewController, HomePageViewElementsLayout  {
    //MARK: View Controller Properties
    var listener: HomePagePresentableListener?
    lazy var label: UILabel! = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        self.view.addSubview(label)
        return label
    }()
    
    lazy var button: UIButton! = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    @IBAction func buttonClicked(button: UIButton) {
        guard let listener = self.listener else {return}
        listener.jumpToLoginPage()
    }
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.doViewControllerLayout()
    }
}

extension HomePageViewController: HomePagePagePresentable {
    func showLoginPageTestNumber(_ number: String) {
        self.label.text = number
    }
}

extension HomePageViewController: HomePageViewControllable {
    func pushToTargetViewController(_ controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
