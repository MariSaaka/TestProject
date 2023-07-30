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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
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
            characterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            characterImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            characterImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4),
            characterImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -4),
        ])
    }
    
    func configure(with model: Character) {
        self.characterImage.loaderView?.isHidden = false
        ImageManager.downloadImage(from: model.image) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.characterImage.loaderView?.isHidden = true
                    self.characterImage.image = image
                }
            case .failure(_ ):
                break
            }
        }
    }
}
