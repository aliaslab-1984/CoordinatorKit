//
//  StoryboardInstantiable.swift
//  CoordinatorKit
//
//  Created by Davide on 19/04/2019.
//  Copyright © 2019 AliasLab SpA. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: - StoryboardInstantiable protocol

// semplificazione nell'uso e retrocompatibilità
public protocol StoryboardInstantiable: Instantiable {}

public extension StoryboardInstantiable {
    
    static var fromStoryboard: InstanceMode {
        return .storyboard(name: nil)
    }
}

// MARK: - Instantiable protocol
public protocol Instantiable {
    
    static var fromStoryboard: InstanceMode { get }

    static func makeInstance() -> Self
    static func makeInstance(storyboard name: String) -> Self
}

public extension Instantiable where Self: UIViewController {
    
    /// Static instantiation from the storyboard of a view controller. (Notice that this method instantiate from the Main.storyboard, if you want to instantiate from a diffrent storyboard use the other static method.)
    /// - Parameter dependencies: The list of dependencies needed by the desired view controller.
    static func makeInstance() -> Self {
        
        switch Self.fromStoryboard {
        case .programmatic:
            return Self.init()
        case .storyboard(let name):
            if let name = name {
                return Self.makeInstance(storyboard: name)
            } else {
                return Self.makeInstance(storyboard: "Main")
            }
        }
    }
    
    /// Static instantiation from the storyboard name of a view controller.
    /// - Parameter dependencies: The list of dependencies needed by the desired view controller.
    /// - Parameter storyboard: The name (without the .storyboard extension) of the storyboard in which the view controller is located.
    static func makeInstance(storyboard name: String) -> Self {
        
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
#endif
