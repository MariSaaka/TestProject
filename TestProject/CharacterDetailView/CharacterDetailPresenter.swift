//
//  CharacterDetailPresenter.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 24/7/23.
//

import Foundation

protocol CharacterDetailPresenter {
    var view: CharacterDetailViewProtocol? { get set }
    func viewDidLoad(characterId: Int)
//    func getCharacterDetails(at index: Int) -> CharacterDetailCell.CellModel
    
}

class CharacterDetailImplementation: CharacterDetailPresenter {
    weak var view: CharacterDetailViewProtocol?
    var characterManager: CharacterDetailDataManager
    
    
    init(manager: CharacterDetailDataManager) {
        self.characterManager = manager
    }
    
    func viewDidLoad(characterId: Int) {
//        let url = "https://rickandmortyapi.com/api/character/\(characterId)"
//        characterManager.startFetchData(with: URL(string: url)!) { result in
//            switch result {
//            case.success(let characters):
//                self.view?.setUpCharacterDetails()
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
    
//    func getCharacterDetails(at index: Int) -> CharacterDetailCell.CellModel {
//        return characterManager.getCharacterDetails(at: index)
//    }
}
