//___FILEHEADER___

import Architecture

protocol ___VARIABLE_productName___ViewableListenerable: class {
    //MARK: 定义一些当前页面需要的业务逻辑, 比如网络请求.
}

protocol ___VARIABLE_productName___ViewableInteractable: class {
    //MARK: 用于定义其他的Component需要定义的协议方法
}

protocol ___VARIABLE_productName___ViewablePresentable: MolueViewablePresentable {
    //MARK: 定义一些页面需要的方法, 比如刷新页面的显示内容等.
    var listener: ___VARIABLE_productName___ViewableListenerable? { get set }
}

final class ___VARIABLE_productName___ViewableInteractor: MolueViewableInteractable {
    
    unowned var presenter: ___VARIABLE_productName___ViewablePresentable
    
    weak var listener: ___VARIABLE_productName___ViewableInteractable?
    
    required init(presenter: ___VARIABLE_productName___ViewablePresentable) {
        self.presenter = presenter
        presenter.listener = self
    }
}

extension ___VARIABLE_productName___ViewableInteractor: ___VARIABLE_productName___ViewableListenerable {
    
}

final class ___VARIABLE_productName___ViewableBuilder {
    func build(listener: ___VARIABLE_productName___ViewableInteractable?) -> Void {
        
        let interactor = ___VARIABLE_productName___ViewableInteractor(presenter: presenter)
        interactor.listener = listener
    }
}
