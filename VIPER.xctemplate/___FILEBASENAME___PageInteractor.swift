//___FILEHEADER___

import Architecture

protocol ___VARIABLE_productName___ViewableRouting: class {
    // 定义一些页面跳转的方法, 比如Push, Presenter等.
}

protocol ___VARIABLE_productName___PagePresentable: MolueInteractorPresentable {
    var listener: ___VARIABLE_productName___PresentableListener? { get set }
    // 定义一些页面需要的方法, 比如刷新页面的显示内容等.
}

final class ___VARIABLE_productName___PageInteractor: MoluePresenterInteractable {
    
    weak var presenter: ___VARIABLE_productName___PagePresentable?
    
    var viewRouter: ___VARIABLE_productName___ViewableRouting?
    
    weak var listener: ___VARIABLE_productName___InteractListener?
    
    required init(presenter: ___VARIABLE_productName___PagePresentable) {
        self.presenter = presenter
        presenter.listener = self
    }
}

extension ___VARIABLE_productName___PageInteractor: ___VARIABLE_productName___RouterInteractable {
    
}

extension ___VARIABLE_productName___PageInteractor: ___VARIABLE_productName___PresentableListener {
    
}
