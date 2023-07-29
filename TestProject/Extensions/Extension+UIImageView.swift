//
//  Extension+UIImageView.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 29/7/23.
//

import UIKit


extension UIImageView {
    
    var loaderView: UIView? {
        get {
            if(self.viewWithTag(956043) == nil) {
                let main = UIView()
                main.tag = 956043
                let view = UIActivityIndicatorView(style: .medium)
                view.startAnimating()
                view.translatesAutoresizingMaskIntoConstraints = false
                main.addSubview(view)
                main.frame = self.bounds
                self.addSubview(main)
                let horizontalConstraint = view.centerXAnchor.constraint(equalTo: main.centerXAnchor)
                let verticalConstraint = view.centerYAnchor.constraint(equalTo: main.centerYAnchor)
                let widthConstraint = view.widthAnchor.constraint(equalToConstant: 44)
                let heightConstraint = view.heightAnchor.constraint(equalToConstant: 44)
                NSLayoutConstraint.activate([
                    horizontalConstraint,
                    verticalConstraint,
                    widthConstraint,
                    heightConstraint])
            }
            
            return self.viewWithTag(956043)
        }set {
            if let oldView = self.viewWithTag(956043){
                oldView.removeFromSuperview()
            }
            
            if let view = newValue {
                view.tag = 956043
                self.addSubview(view)
            }
        }
    }
}
