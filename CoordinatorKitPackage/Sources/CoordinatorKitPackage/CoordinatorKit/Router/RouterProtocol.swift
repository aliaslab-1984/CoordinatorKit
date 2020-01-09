//
//  RouterProtocol.swift
//  CoordinatorKit
//
//  Created by Davide on 10/04/2019.
//  Copyright © 2019 AliasLab SpA. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presentable
public protocol Presentable {
    func toPresent() -> UIViewController?
}

// MARK: - RouterProtocol
public typealias NavigateBackDelegate = (() -> Void)

public protocol RouterProtocol {
    
    var navigationController: UINavigationController { get set }
    
    func push(_ module: Presentable, transition: Transition?, onNavigateBack: NavigateBackDelegate?)
    func pop(transition: Transition?)
    
    func present(_ module: Presentable, animated: Bool, onNavigateBack: NavigateBackDelegate?)
    func dismiss(animated: Bool)
    
    func popToRoot(transition: Transition?)
}

// MARK: - UIViewController+Presentable
extension UIViewController: Presentable {
    
    public func toPresent() -> UIViewController? {
        return self
    }
}
