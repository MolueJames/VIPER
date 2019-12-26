//
//  MolueViewableInteractor.swift
//  Architecture
//
//  Created by James on 2019/12/26.
//  Copyright © 2019 Molue. All rights reserved.
//

import Foundation

public protocol MolueViewableInteractable: class {
    associatedtype Presentable
    
    init(presenter: Presentable)
    
    var presenter: Presentable { get }
}

public protocol MolueViewablePresentable: class {
    
}
