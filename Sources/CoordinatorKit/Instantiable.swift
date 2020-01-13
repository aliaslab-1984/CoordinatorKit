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

// MARK: - Instantiable protocol
public protocol Instantiable {
    
    associatedtype Dependencies
    
    var dependencies: Dependencies? {get set}
    static var fromStoryboard: InstanceMode { get }

    static func makeInstance(dependencies: Dependencies) -> Self
    static func makeInstance(dependencies: Dependencies, storyboard name: String) -> Self
}

public extension Instantiable where Self: UIViewController {
    
    /// Static instantiation from the storyboard of a view controller. (Notice that this method instantiate from the Main.storyboard, if you want to instantiate from a diffrent storyboard use the other static method.)
    /// - Parameter dependencies: The list of dependencies needed by the desired view controller.
    public static func makeInstance(dependencies: Dependencies) -> Self {
        
        switch Self.fromStoryboard {
        case .programmatic:
            var instance = Self.init()
            instance.dependencies = dependencies
            
            return instance
        case .storyboard(let name):
            if let name = name {
                return Self.makeInstance(dependencies: dependencies, storyboard: name)
            } else {
                return Self.makeInstance(dependencies: dependencies, storyboard: "Main")
            }
        }
    }
    /// Static instantiation from the storyboard name of a view controller.
    /// - Parameter dependencies: The list of dependencies needed by the desired view controller.
    /// - Parameter storyboard: The name (without the .storyboard extension) of the storyboard in which the view controller is located.
    public static func makeInstance(dependencies: Dependencies, storyboard name: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        // swiftlint:disable:next force_cast
        var instance = storyboard.instantiateViewController(withIdentifier: className) as! Self
        instance.dependencies = dependencies
        return instance
    }
}
#endif
