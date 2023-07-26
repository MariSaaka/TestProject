//
//  CharacterDetailViewController.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    func setUpCharacterDetails()
}

class CharacterDetailViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var presenter: CharacterDetailPresenter
    var index: Int = 0
    var characterId: Int = 0
    
    // MARK: - Init
    init(presenter: CharacterDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        presenter.viewDidLoad(characterId: characterId)
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterDetailCell.self, forCellWithReuseIdentifier: "ContactDetailCell")
    }

}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactDetailCell", for: indexPath) as! CharacterDetailCell
//            let character = presenter.getCharacterDetails(at: self.index)
//            print(character)
//            cell.configure(with: character)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 200)
        
    }
    
}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func setUpCharacterDetails() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
