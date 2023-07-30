//
//  CharacterCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    typealias Model = CharacterCell.CellModel
    
    // MARK: - Private Variables
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var characterGender: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.applyContentStyle(withShadow: false)
        contentView.clipsToBounds = true
    }
    
    
    // MARK: -Private Functions
    private func setUpCell() {
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
        verticalStackView.addArrangedSubview(characterGender)
    }
    
    private func setUpHorizontalStackView() {
        mainStackView.addArrangedSubview(characterImage)
        mainStackView.addArrangedSubview(verticalStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.widthAnchor.constraint(equalToConstant: 120),
            characterImage.heightAnchor.constraint(equalToConstant: 118)
        ])
        addConstraintsToMainStackView()
    }
    
    private func addConstraintsToMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mainStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        ])
    }
    
    func configure(with model: Model) {
        self.characterName.text = model.name
        self.characterGender.text = model.status
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

// MARK: - CellModel
extension CharacterCell {
    struct CellModel {
        let name: String
        let status: String
        var image: String
    }
}
