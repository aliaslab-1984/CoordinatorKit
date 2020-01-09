//
//  Coordinator.swift
//  IDSign Mobile Demo
//
//  Created by Davide on 05/04/2019.
//  Copyright © 2019 AliasLab S.p.A. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Coordinator
public protocol Coordinator: AnyObject, Presentable {
    
    var childCoordinators: [Coordinator] { get set }
    var router: RouterProtocol { get }
    
    func start() -> Bool
}

public extension Coordinator {
    
    /// Add's a new child coordinator to the children list.
    /// - Parameter child: coordinator child to add.
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    /// Utility method that removes an existing coordinator from the children list.
    /// - Parameter child: The actual item that needs to be deleted.
    func removeChild(_ child: Coordinator?) {
        let childIndex = childCoordinators.lastIndex { $0 === child }
        if let index = childIndex {
            childCoordinators.remove(at: index)
        }
    }
    
    /// Utility method that handles the addition of more than one child coordinator to the parent coordinator
    /// - Parameter items: The array of childrens to add to the parent
    func addChildren(_ items: [Coordinator]) {
        childCoordinators.append(contentsOf: items)
    }
}

public protocol DismissableFlow {
    var dismissFlow: (() -> Void)? { get set }
}

public protocol CompletableFlow {
    
    associatedtype FlowOutput
    
    var finishFlow: ((FlowOutput) -> Void)? { get set }
}
#endif
