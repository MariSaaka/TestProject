//
//  CharacterDetailViewController.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    func setUpCharacterDetails()
    func updateUI()
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
        fetchEpisodes()
    }

    //MARK: - Private Functions
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        addConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterDetailCell.self, forCellWithReuseIdentifier: "ContactDetailCell")
        collectionView.register(EpisodeHeaderCell.self, forCellWithReuseIdentifier: "EpisodeExpandableHeaderCell")
        collectionView.register(EpisodeCharactersExpandableCell.self, forCellWithReuseIdentifier: "EpisodeCharactersExpandableCell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    private func fetchEpisodes() {
        presenter.viewDidLoad()
    }
}


//MARK: - UICollectionView
extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2 * presenter.numberOfEpisodes()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactDetailCell", for: indexPath) as! CharacterDetailCell
            let character = presenter.getCharacterDetails()
            cell.configure(with: character)
            return cell
        }
        if indexPath.section == 1 {
            if indexPath.row % 2 == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeExpandableHeaderCell", for: indexPath) as! EpisodeHeaderCell
                let episode = presenter.getEpisode(at: indexPath.row / 2)
                
                cell.configure(with: episode)
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCharactersExpandableCell", for: indexPath) as! EpisodeCharactersExpandableCell
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch (indexPath.section, indexPath.row ) {
        case(0, 0):
            return CGSize(width: collectionView.bounds.size.width, height: 400)
        case(1, let row) where row % 2 == 0:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        case(1, let row) where row % 2 != 0:
            return CGSize(width: collectionView.bounds.size.width, height: 80)
        default:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        }
    }
}

//MARK: - CharacterDetailViewProtocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func setUpCharacterDetails() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
