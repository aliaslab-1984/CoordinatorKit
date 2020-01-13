//
//  File.swift
//  
//
//  Created by Francesco Bianco on 13/01/2020.
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol WithDependencies {
    associatedtype Dependencies
    
    var dependencies: Dependencies? {get set}
}

#endif
