//
//  File.swift
//  
//
//  Created by Francesco Bianco on 13/01/2020.
//

import Foundation
#if canImport(UIKit)
import UIKit

/// Protocol used to describe the dependencies required by the delegates that implements it.
public protocol WithDependencies {
    associatedtype Dependencies
    
    var dependencies: Dependencies? {get set}
}

#endif
