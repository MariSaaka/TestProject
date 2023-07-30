//
//  ContactDetailCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

class CharacterDetailCell: UICollectionViewCell {
    //MARK: - Private Variables
    typealias Model = CharacterDetailCell.CellModel
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var imageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 220),
            view.heightAnchor.constraint(equalToConstant: 220)
        ])
        return view
    }()
    
    private var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        return imageView
    }()
    
    private var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var characterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var characterGender: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var characterStatus: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var characterSpecies: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var characterLocation: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.applyContentStyle(withShadow: true)
        characterImage.layer.masksToBounds = false
        characterImage.clipsToBounds = true
    }
    
    
    //MARK: - Private Functions
    private func setUp() {
        supportDarkMode()
        addSubviews()
        addConstraints()
    }
    
    private func supportDarkMode() {
        contentView.backgroundColor = UIColor.viewBackgroundColor
    }
    
   
    private func addSubviews() {
        setUpVerticalStackView()
        setUpHorizontalStackView()
        self.contentView.addSubview(mainStackView)
    }
    
    
    private func setUpVerticalStackView() {
        verticalStackView.addArrangedSubview(characterName)
        verticalStackView.addArrangedSubview(characterStatus)
        verticalStackView.addArrangedSubview(characterLocation)
        verticalStackView.addArrangedSubview(characterSpecies)
        verticalStackView.addArrangedSubview(characterGender)
    }
    
    private func setUpHorizontalStackView() {
        imageInputView.addSubview(characterImage)
        mainStackView.addArrangedSubview(imageInputView)
        mainStackView.addArrangedSubview(verticalStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.centerXAnchor.constraint(equalTo: imageInputView.centerXAnchor),
            characterImage.centerYAnchor.constraint(equalTo: imageInputView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mainStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        ])
    }
    
    
    func configure(with model: Model) {
        self.characterName.text = model.name
        self.characterStatus.text = model.status
        self.characterLocation.text = model.location
        self.characterSpecies.text = model.species
        self.characterGender.text = model.gender
        ImageManager.downloadImage(from: model.image) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.characterImage.image = image
                }
            case .failure(_ ):
                break
            }
        }
    }
}

//MARK: - CharacterDetailCell.CellModel
extension CharacterDetailCell {
    struct CellModel {
        let name: String
        let status: String
        let species: String
        let gender: String
        var image: String
        let location: String
    }
}
