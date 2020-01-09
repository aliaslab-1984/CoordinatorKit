//
//  BasicCoordinator.swift
//  DocumentReader
//
//  Created by Enrico on 02/01/2020.
//  Copyright © 2020 AliasLab SpA. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Foundation

public protocol Coordinated: UIViewController where Self: StoryboardInstantiable {
    
    func setCoordinator(coordinator: GenericCoordinator<Self>?)
}

/**
 Riduce il codice duplicato nei coordinator; necessita che i ViewController adottino il protocollo setCoordinator
 */
open class GenericCoordinator<T: StoryboardInstantiable & Coordinated> {
    
    let dependencies: T.Dependencies
    
    public var childCoordinators = [Coordinator]()
    public let router: RouterProtocol
    
    private lazy var viewController: T = { [unowned self] in
        return T.makeInstance(dependencies: dependencies)
    }()
    
    public init(router: RouterProtocol,
         dependencies: T.Dependencies) {
        
        self.router = router
        self.dependencies = dependencies
    }
    
    public func genericDependencies() -> AnyClass {
        
        return dependencies as! AnyClass
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
