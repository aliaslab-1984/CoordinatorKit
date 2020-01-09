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

protocol Coordinated: UIViewController where Self: StoryboardInstantiable {
    
    func setCoordinator(coordinator: GenericCoordinator<Self>?)
}

/**
 Riduce il codice duplicato nei coordinator; necessita che i ViewController adottino il protocollo setCoordinator
 */
class GenericCoordinator<T: StoryboardInstantiable & Coordinated> {
    
    let dependencies: T.Dependencies
    
    var childCoordinators = [Coordinator]()
    let router: RouterProtocol
    
    private lazy var viewController: T = { [unowned self] in
        return T.makeInstance(dependencies: dependencies)
    }()
    
    init(router: RouterProtocol,
         dependencies: T.Dependencies) {
        
        self.router = router
        self.dependencies = dependencies
    }
    
    func genericDependencies() -> AppDependencies {
        
        guard let dep = dependencies as? AppDependencies else {
            fatalError()
        }
        return dep
    }
}

extension GenericCoordinator: Presentable {
    
    func toPresent() -> UIViewController? {
        return viewController
    }
}

extension GenericCoordinator: Coordinator {
    
    func start() -> Bool {
        
        viewController.setCoordinator(coordinator: self)
        return true
    }
}
#endif