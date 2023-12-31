//
//  EpisodeHeaderCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 27/7/23.
//

import UIKit

class EpisodeHeaderCell: UICollectionViewCell {
    //MARK: - Private Varibles
    
    typealias Model = EpisodeHeaderCell.CellModel
    
    
    private var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .label
        label.textAlignment = .center
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
        contentView.applyContentStyle(withShadow: false)
    }
    
    
    // MARK: - Private Functions
    private func setUp() {
        contentView.backgroundColor = UIColor.viewBackgroundColor
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        self.titleView.addSubview(titleLabel)
        self.contentView.addSubview(titleView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            titleView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }
    
    func configure(with model: Model) {
        self.titleLabel.text = model.name
    }
}

//MARK: - EpisodeExpandableHeaderCell.CellModel
extension EpisodeHeaderCell {
    struct CellModel {
        let name: String
    }
}

