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

public protocol DependenciesValidator {
    
}

// MARK: - StoryboardInstantiable
public protocol StoryboardInstantiable: WithDependencies {

    static func makeInstance(dependencies: Dependencies) -> Self
    static func makeInstance(dependencies: Dependencies, storyboard name: String) -> Self
}

public extension StoryboardInstantiable where Self: WithDependencies {
    
    public static func makeInstance(dependencies: Dependencies) -> Self {
        return Self.makeInstance(dependencies: dependencies, storyboard: "Main")
    }
    
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
