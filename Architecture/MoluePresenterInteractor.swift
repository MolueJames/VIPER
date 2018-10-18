//
//  MolueInteractor.swift
//  MolueFoundation
//
//  Created by MolueJames on 2018/9/22.
//  Copyright © 2018年 MolueTech. All rights reserved.
//

import Foundation

public protocol MolueInteractorPresentable: class {}

public protocol MoluePresenterInteractable: class {
    associatedtype Presentable
    
    init(presenter: Presentable)
    
    var presenter: Presentable? {get set}
}

