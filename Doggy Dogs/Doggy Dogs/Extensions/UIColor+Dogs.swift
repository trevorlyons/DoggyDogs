//
//  UIColor+Dogs.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 15/04/2021.
//

import UIKit

extension UIColor {
    
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
