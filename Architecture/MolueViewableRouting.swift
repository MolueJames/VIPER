//
//  MolueViewableRouting.swift
//  MolueMediator
//
//  Created by MolueJames on 2018/10/3.
//  Copyright © 2018 MolueJames. All rights reserved.
//

import Foundation
public protocol MolueViewableRouting: class {
    associatedtype Interactable
    associatedtype Controllerable
    
    init(interactor: Interactable, controller: Controllerable)
    
    var interactor: Interactable? {get set}
    var controller: Controllerable? {get set}
}
