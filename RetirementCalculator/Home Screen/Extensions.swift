//
//  Extensions.swift
//  RetirementCalculator
//
//  Created by Bhavani Nainala on 3/13/22.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    
    static func instantiateFromMain() -> Self {
        let storyboardIdentifier = String(describing: self)
        // `Main` can be your stroyboard name.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
}
