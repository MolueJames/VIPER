//
//  MolueBuilderFactory.swift
//  MolueMediator
//
//  Created by MolueJames on 2018/9/22.
//  Copyright © 2018年 MolueJames. All rights reserved.
//

import Foundation
public protocol MolueBuilderPathProtocol {
    func builderPath() -> String
}
open class MolueBuilderFactory<Component: MolueBuilderPathProtocol> {
    
    private let component: Component
    
    open func queryBuilder<T> () -> T? {
        let className = component.builderPath()
        guard let targetCalss: AnyClass = NSClassFromString(className) else {return nil}
        guard let targetBuilder = targetCalss as? MolueComponentBuilder.Type else {return nil}
        guard let resultBuilder = targetBuilder.init() as? T else {return nil}
        return resultBuilder
    }
    
    public init(_ component: Component) {
        self.component = component;
    }
}

