//
//  LoginPageViewController.swift
//  Demo
//
//  Created by MolueJames on 2018/10/20.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import UIKit

protocol LoginPagePresentableListener: LoginPageViewableInteractable {
    // 定义一些当前页面需要的业务逻辑, 比如网络请求.
    func didSelectedTestNumber(_ number: String)
    var list: [String]? {get}
    func viewControllerDidLoad()
}

protocol LoginPageViewElementsLayout where Self: LoginPageViewController{
    var tableView: UITableView! {get}
    func doViewControllerLayout()
}

extension LoginPageViewElementsLayout {
    func doViewControllerLayout() {
        self.tableView.frame = self.view.bounds
    }
}

final class LoginPageViewController: UIViewController, LoginPageViewElementsLayout  {
    //MARK: View Controller Properties
    var listener: LoginPagePresentableListener?
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
        return tableView
    }()
    
    lazy var headerView: LoginPageHeaderView! = {
        let builder = LoginPageViewableBuilder()
        return builder.build(listener: self.listener)
    }()
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.doViewControllerLayout()
        self.listener?.viewControllerDidLoad()
    }
}

extension LoginPageViewController: LoginPagePagePresentable {
    
}

extension LoginPageViewController: LoginPageViewControllable {
    func doPopBackFromLoginPage() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LoginPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listener?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")!
        cell.textLabel?.text = self.listener?.list?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listener = self.listener else {return}
        listener.didSelectedTestNumber(self.listener?.list?[indexPath.row] ?? "0")
    }
    
}
