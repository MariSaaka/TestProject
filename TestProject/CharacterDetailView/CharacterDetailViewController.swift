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
    func updateSection(at index: Int)
}

class CharacterDetailViewController: UIViewController {

    //MARK: - Private Variables
    private var collectionView: UICollectionView!
    var presenter: CharacterDetailPresenter?
    var numberOfEpisodes = 0
    var sectionIsExpanded: [Int : Bool] = [:]
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with configurator: CharacterDetailViewConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.createCharacterDetailViewController(viewController: self)
    }
    
    //MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchEpisodes()
        fillSectionArray()
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
        presenter?.viewDidLoad()
        numberOfEpisodes = presenter?.numberOfEpisodes() ?? 0
    }
    
    private func fillSectionArray() {
        for section in 0...numberOfEpisodes {
            sectionIsExpanded[section] = false
        }
    }
}


//MARK: - UICollectionView
extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1 + (presenter?.numberOfEpisodes() ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return sectionIsExpanded[section] == true ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactDetailCell", for: indexPath) as! CharacterDetailCell
            if let character = presenter?.getCharacterDetails() {
                cell.configure(with: character)
            }
            return cell
        } else {
            if indexPath.row == 0  {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeExpandableHeaderCell", for: indexPath) as! EpisodeHeaderCell
                if let episode = presenter?.getEpisode(at: indexPath.section - 1) {
                    cell.configure(with: episode)
                }
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCharactersExpandableCell", for: indexPath) as! EpisodeCharactersExpandableCell
             
                cell.delegate = presenter
                let cellModel = presenter?.getEpisodeCharacters(at: indexPath.section)
                cell.updateWith(characters: cellModel)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if indexPath.row == 0 {
                let section = indexPath.section
                if let isExpanded = sectionIsExpanded[section] {
                    sectionIsExpanded[section] = !isExpanded
                    collectionView.performBatchUpdates({
                        collectionView.reloadSections(IndexSet(integer: section))
                    }, completion: nil)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch (indexPath.section, indexPath.row ) {
        case(0, 0):
            return CGSize(width: collectionView.bounds.size.width, height: 400)
        case(_ , let row) where row % 2 == 0:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        case(_ , let row) where row % 2 != 0:
            if indexPath.row == 1 && sectionIsExpanded[indexPath.section] == false {
                return CGSize(width: 0, height: 0)
            } else {
                return CGSize(width: collectionView.bounds.size.width, height: 140)
            }
        default:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section != 0 {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 4, left: 0, bottom: 64, right: 0)
        }
        return UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - CharacterDetailViewProtocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func updateSection(at index: Int) {
        let indexSet = IndexSet(integer: index)
        DispatchQueue.main.async {
            self.collectionView.reloadSections(indexSet)
        }
    }
    
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
