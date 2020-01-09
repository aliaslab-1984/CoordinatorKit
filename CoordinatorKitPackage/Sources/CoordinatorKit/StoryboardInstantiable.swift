//
//  StoryboardInstantiable.swift
//  CoordinatorKit
//
//  Created by Davide on 19/04/2019.
//  Copyright © 2019 AliasLab SpA. All rights reserved.
//

import Foundation
#if canImport(UIKit)

// MARK: - StoryboardInstantiable
public protocol StoryboardInstantiable {
    
    associatedtype Dependencies
    var dependencies: Dependencies? { get set }
    
    static func makeInstance(dependencies: Dependencies) -> Self
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static func makeInstance(dependencies: Dependencies, storyboard name: String = "Main") -> Self {
        
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
