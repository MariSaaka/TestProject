//
//  Extension+UIColor.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 30/7/23.
//

import UIKit

extension UIColor {
    static var viewBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(white: 0.3, alpha: 1.0)
                default:
                    return UIColor(white: 1, alpha: 1.0)
                }
            }
        } else {
            return UIColor.white
        }
    }
}

