//
//  EpisodeCharactersExpandableCell.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 27/7/23.
//

import UIKit

class EpisodeCharactersExpandableCell: UICollectionViewCell {

    var childCollectionView: UICollectionView!
    var episodeCharacters : [Character]?
    weak var delegate: EpisodeCharactersExpandableCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.viewBackgroundColor
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
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            childCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            childCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            childCollectionView.topAnchor.constraint(equalTo: topAnchor),
            childCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateWith(characters: [Character]?) {
        self.episodeCharacters = characters
        DispatchQueue.main.async {
            self.childCollectionView.reloadData()
        }
    }
}

extension EpisodeCharactersExpandableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeCharacters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChildCollectionViewCell.reuseIdentifier, for: indexPath) as! ChildCollectionViewCell
        if let episodeCharacters = episodeCharacters {
            let character = episodeCharacters[indexPath.row]
            cell.configure(with: character)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let episodeCharacters = episodeCharacters {
            let selectedCharacter = episodeCharacters[indexPath.row]
            print(selectedCharacter.name)
            self.delegate?.selectCharacter(character: selectedCharacter)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}


protocol EpisodeCharactersExpandableCellDelegate: AnyObject {
    func selectCharacter(character: Character)
}
