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

// 组件间解耦工具。
import Foundation
import UIKit

public typealias OMethodProtocol = MethodAction & OMethodValidate

public typealias CMethodProtocol = MethodAction & CMethodValidate

public class THMethodManager {
    
    public static let `default` = THMethodManager()
    
    var methodList: [MethodAction] = []
    
    private var lock: NSLock = .init()
    
    public func method(with name: String) -> MethodAction? {
        return self.methodList.first { action in
            return action.actionName() == name
        }
    }
    
    public func insert(_ action: MethodAction) {
        lock.lock(); defer { lock.unlock() }
        if self.methodList.contains(where: {
            $0.actionName() == action.actionName()
        }) { fatalError("已存在相同actionName的") }
        self.methodList.append(action)
    }
    
    public var currentMethods: [String] {
        return self.methodList.compactMap {
            return $0.actionName()
        }
    }
    
}

public protocol MethodValidate {
    
    associatedtype I

    associatedtype R
    
    associatedtype T
    
    var TClass: T.Type { get }
    
    var RClass: R.Type { get }
    
    var IClass: I.Type { get }
   
}

public extension MethodValidate where Self: MethodAction {
    
    var IClass: I.Type { return I.self }
    
    var RClass: R.Type { return R.self }
    
    var TClass: T.Type { return T.self }
    
    func vparams(for param: Any) throws -> I {
        if let result = param as? I {
            return result
        } else {
            let explain = self.description
            throw ActionError.params(explain)
        }
    }
    
    func vresult(for result: Any) throws -> R {
        if let result = result as? R {
            return result
        } else {
            let explain = self.description
            throw ActionError.output(explain)
        }
    }
    
    var description: String {
        return """
               方法入参类型: \(IClass),
               方法出参类型: \(RClass),
               调用对象类型: \(TClass),
               """
    }
}

public protocol MethodAction {
    
    func perform(_ target: Any, params: Any) throws -> Any
    
    func actionName() -> String
    
    var description: String { get }
    
    var explanation: String { get }
}

public protocol OMethodValidate: MethodValidate {
    func perform(_ target: T, _ params: I) -> R
}

public protocol CMethodValidate: MethodValidate {
    func perform(with params: I) -> R
}

public extension MethodAction where Self: OMethodValidate {
    
    func vtarget(for target: Any) throws -> T {
        if let result = target as? T {
            return result
        } else {
            let explain = self.description
            throw ActionError.target(explain)
        }
    }
    func perform(_ target: Any, params: Any) throws -> Any {
        let target = try vtarget(for: target)
        let params = try vparams(for: params)
        return self.perform(target, params)
    }
}

public extension MethodAction where Self: CMethodValidate {
    
    func perform(_ target: Any, params: Any) throws -> Any {
        let params = try vparams(for: params)
        return self.perform(with: params)
    }
}

public enum ActionError: Error {
    
    case params(String)
    
    case output(String)
    
    case target(String)
    
    case method(String)
}

extension ActionError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .method(let input):
            return "未找到注册方法: " + input
        case .params(let input):
            return "方法入参异常\n" + input
        case .output(let input):
            return "方法出参异常\n" + input
        case .target(let input):
            return "调用对象异常\n" + input
        }
    }
}

public func msg_send(_ name: String, _ target: Any, _ params: Any) throws -> Any {
    let method = THMethodManager.default.method(with: name)
    guard let method = method else { throw ActionError.method(name) }
    return try method.perform(target, params: params)
}

public func registerMethodAction(_ method: MethodAction) {
    THMethodManager.default.insert(method)
}

public func methodDescription(_ name: String) -> String {
    let method = THMethodManager.default.method(with: name)
    guard let method = method else { return "未找到对应的对象" }
    return method.description + "\nClass: \(type(of: method))"
}

public func methodExplanation(_ name: String) -> String {
    let method = THMethodManager.default.method(with: name)
    guard let method = method else { return "未找到对应的对象" }
    return method.explanation + "\nClass: \(type(of: method))"
}

public func registerMethodList() -> [String] {
    return THMethodManager.default.methodList.compactMap {
        "name: " + $0.actionName() + " class: \(type(of: $0))"
    }
}

public func build<T>(_ name: String, _ target: Any, _ params: Any) throws -> T {
    let result = try msg_send(name, target, params)
    guard let result = result as? T else {
        throw THMethodError.resultNotMatched
    }
    return result
}

public enum THMethodError: Error {
    case resultNotMatched
}
