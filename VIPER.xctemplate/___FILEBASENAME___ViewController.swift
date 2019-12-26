//___FILEHEADER___

import UIKit

protocol ___VARIABLE_productName___PresentableListener: class {
    // 定义一些当前页面需要的业务逻辑, 比如网络请求.
}

protocol ___VARIABLE_productName___ViewElementsLayout where Self: ___VARIABLE_productName___ViewController {
    // 页面初始化的布局方法, 如果当前页面需要其他的布局方法,需要在当前协议中添加方法即可.
    func doViewControllerLayout()
    // 可以在该协议下定义当前页面所需要的页面元素, 并且在使用该协议的类中使用懒加载模式去更新元素其他属性.
}

extension ___VARIABLE_productName___ViewElementsLayout {
    func doViewControllerLayout() {
    }
}

final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___ViewElementsLayout {
    //MARK: View Controller Properties
    var listener: ___VARIABLE_productName___PresentableListener?
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___PagePresentable {
    
}

extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewControllable {
    
}
