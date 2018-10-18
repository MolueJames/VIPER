//___FILEHEADER___

import UIKit

protocol ___VARIABLE_productName___PresentableListener: class {
    // 定义一些当前页面需要的业务逻辑, 比如网络请求.
}

final class ___VARIABLE_productName___ViewController: UIViewController  {
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
