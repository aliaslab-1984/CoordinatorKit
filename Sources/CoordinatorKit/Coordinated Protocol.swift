//
//  File.swift
//  
//
//  Created by Francesco Bianco on 09/01/2020.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Coordinated: UIViewController where Self: WithDependencies {
    /// Assigns a coordinator to it's delegate
    /// - Parameter coordinator: the coordinator to be assigned.
    func setCoordinator(coordinator: Coordinator?)
}
#endif
