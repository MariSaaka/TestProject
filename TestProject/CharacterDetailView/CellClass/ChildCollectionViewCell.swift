//
//  ChildCollectionViewCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 29/7/23.
//

import UIKit

class ChildCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ChildCollectionViewCell"

    private var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUp() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(characterImage)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.heightAnchor.constraint(equalToConstant: 80),
            characterImage.widthAnchor.constraint(equalToConstant: 80),
            characterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            characterImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            characterImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4),
            characterImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -4),
        ])
    }
}
