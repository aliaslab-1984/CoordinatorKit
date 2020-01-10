//
//  File.swift
//  
//
//  Created by Francesco Bianco on 09/01/2020.
//

import Foundation

#if canImport(UIKit)
import UIKit

open class GenericCoordinator<T: Coordinated & StoryboardInstantiable> {
    
    public var childCoordinators = [Coordinator]()
    public let router: RouterProtocol
    
    let dependencies: CoordinatorDependencies
    
    public typealias CoordinatorDependencies = T.Dependencies
    
    private lazy var viewController: T = { [unowned self] in
        return T.makeInstance(dependencies: dependencies)
    }()
    
    public init(router: RouterProtocol,
         dependencies: CoordinatorDependencies) {
        
        self.router = router
        self.dependencies = dependencies
    }

    public func genericDependencies() -> CoordinatorDependencies {
        return dependencies
    }
    
}

extension GenericCoordinator: Presentable {
    
    public func toPresent() -> UIViewController? {
        return viewController
    }
}

extension GenericCoordinator: Coordinator {
    
    public func start() -> Bool {
        
        viewController.setCoordinator(coordinator: self)
        return true
    }
}


#endif
