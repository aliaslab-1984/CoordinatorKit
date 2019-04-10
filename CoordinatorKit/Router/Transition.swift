//
//  Transition.swift
//  CoordinatorKit
//
//  Created by Davide on 10/04/2019.
//  Copyright © 2019 AliasLab SpA. All rights reserved.
//

import Foundation

// MARK: - Transition
public enum Transition {
    case fade
    case moveIn(direction: CATransitionSubtype)
    case reveal(direction: CATransitionSubtype)
}

extension Transition {
    
    func apply(to navigationController: UINavigationController) {
        navigationController.view.layer.add(self.makeCATransition(), forKey: nil)
    }
}

// MARK: - Helpers
private extension Transition {
    
    func makeCATransition() -> CATransition {
        
        let result = CATransition()
        
        switch self {
        case .fade:
            result.duration = 0.1
            result.type = .fade
        case .moveIn(let direction):
            result.duration = 0.3
            result.type = .moveIn
            result.subtype = direction
        case .reveal(let direction):
            result.duration = 0.3
            result.type = .reveal
            result.subtype = direction
        }
        
        return result
    }
}
