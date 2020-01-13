//
//  File.swift
//  
//
//  Created by Francesco Bianco on 09/01/2020.
//

import Foundation

#if canImport(UIKit)
import UIKit

open class GenericCoordinator<T: Coordinated & WithDependencies> {
    
    public var childCoordinators = [Coordinator]()
    public let router: RouterProtocol
    
    let dependencies: T.Dependencies
    
    private lazy var viewController: T = { [unowned self] in
        if let casted = T as? StoryboardInstantiable {
            return casted.makeInstance(dependencies: dependencies)
        } else {
            let v = T.init()
            v.dependencies = dependencies
            return v
        }
    }()
    
    public init(router: RouterProtocol,
         dependencies: T.Dependencies) {
        
        self.router = router
        self.dependencies = dependencies
    }

    public func genericDependencies() -> T.Dependencies {
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
