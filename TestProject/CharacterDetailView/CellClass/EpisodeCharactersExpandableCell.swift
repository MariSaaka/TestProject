//
//  EpisodeCharactersExpandableCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 27/7/23.
//

import UIKit

class EpisodeCharactersExpandableCell: UICollectionViewCell {

    var childCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChildCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupChildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        childCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        childCollectionView.translatesAutoresizingMaskIntoConstraints = false
        childCollectionView.backgroundColor = .clear
        childCollectionView.dataSource = self
        childCollectionView.delegate = self

    
        childCollectionView.register(ChildCollectionViewCell.self, forCellWithReuseIdentifier: ChildCollectionViewCell.reuseIdentifier)

        addSubview(childCollectionView)

        NSLayoutConstraint.activate([
            childCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            childCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            childCollectionView.topAnchor.constraint(equalTo: topAnchor),
            childCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension EpisodeCharactersExpandableCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChildCollectionViewCell.reuseIdentifier, for: indexPath) as! ChildCollectionViewCell
        return cell
    }
}
