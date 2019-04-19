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
    var router: RouterProtocol { get }
    
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
