//
//  Router.swift
//  IDSign Mobile Demo
//
//  Created by Davide on 08/04/2019.
//  Copyright © 2019 AliasLab S.p.A. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - Router
public final class Router: NSObject {
    
    public var navigationController: UINavigationController
    private var navigateBackDelegates: [String: NavigateBackDelegate]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigateBackDelegates = [:]
        super.init()
        navigationController.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate
extension Router: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController)  else {
            return
        }
        
        executeNavigateBackDelegate(viewController: poppedViewController)
    }
}

// MARK: - RouterProtocol
extension Router: RouterProtocol {
    
    public func push(_ module: Presentable, transition: Transition?, onNavigateBack: NavigateBackDelegate?) {
        
        guard let viewController = module.toPresent() else {
            return
        }
        
        registerNavigationBackDelegate(viewController: viewController, delegate: onNavigateBack)
        transition?.apply(to: navigationController)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    public func pop(transition: Transition?) {
        
        transition?.apply(to: navigationController)
        guard let poppedViewController = navigationController.popViewController(animated: false) else {
            return
        }
        
        executeNavigateBackDelegate(viewController: poppedViewController)
    }
    
    public func present(_ module: Presentable, animated: Bool, onNavigateBack: NavigateBackDelegate?) {
        
        guard let viewController = module.toPresent() else {
            return
        }
        
        registerNavigationBackDelegate(viewController: viewController, delegate: onNavigateBack)
        navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    public func dismiss(animated: Bool) {
        
        guard let presentedViewController = navigationController.presentedViewController else {
            return
        }
        
        navigationController.dismiss(animated: animated, completion: nil)
        executeNavigateBackDelegate(viewController: presentedViewController)
    }
    
    public func popToRoot(transition: Transition?) {
        
        self.dismiss(animated: transition != nil)
        transition?.apply(to: navigationController)
        guard let poppedViewControllers = navigationController.popToRootViewController(animated: false) else {
            return
        }
        
        poppedViewControllers.forEach { executeNavigateBackDelegate(viewController: $0) }
    }
}

// MARK: - Helpers
private extension Router {
    
    func registerNavigationBackDelegate(viewController: UIViewController, delegate: NavigateBackDelegate?) {
        
        guard let delegate = delegate else {
            return
        }
        
        navigateBackDelegates.updateValue(delegate, forKey: viewController.description)
    }
    
    func executeNavigateBackDelegate(viewController: UIViewController) {
        
        guard let delegate = navigateBackDelegates.removeValue(forKey: viewController.description) else {
            return
        }
        
        delegate()
    }
}
#endif
