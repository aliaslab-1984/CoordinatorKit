//
//  Coordinator.swift
//  IDSign Mobile Demo
//
//  Created by Davide on 05/04/2019.
//  Copyright © 2019 AliasLab S.p.A. All rights reserved.
//

import UIKit

// MARK: - Coordinator
public protocol Coordinator: AnyObject, Presentable {
    
    var childCoordinators: [Coordinator] { get set }
    var router: RouterProtocol { get set }
    
    func start() -> Bool
}

public extension Coordinator {
    
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func removeChild(_ child: Coordinator?) {
        let childIndex = childCoordinators.lastIndex { $0 === child }
        if let index = childIndex {
            childCoordinators.remove(at: index)
        }
    }
}

public protocol DismissableFlow {
    var dismissFlow: (() -> Void)? { get set }
}

public protocol CompletableFlow {
    
    associatedtype FlowOutput
    
    var finishFlow: ((FlowOutput) -> Void)? { get set }
}

// MARK: - StoryboardInstantiable
public protocol StoryboardInstantiable {
    
    static func makeInstance() -> Self
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static func makeInstance() -> Self {
        
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
