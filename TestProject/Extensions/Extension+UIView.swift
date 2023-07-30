//
//  Extension+UIView.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 30/7/23.
//

import UIKit

extension UIView {
    func applyContentStyle(withShadow: Bool) {
        let margins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        self.frame = self.frame.inset(by: margins)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.5
        if withShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = .zero
        }
    }
}


