//
//  File.swift
//  
//
//  Created by Francesco Bianco on 09/01/2020.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol Coordinated: UIViewController where Self: StoryboardInstantiable {
    
    public func setCoordinator(coordinator: GenericCoordinator<Self>?)
    
}


#endif
