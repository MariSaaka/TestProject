//
//  CharacterDetailPresenter.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 24/7/23.
//

import Foundation

protocol CharacterDetailPresenter {
    var view: CharacterDetailViewProtocol? { get set }
    func viewDidLoad()
    func getCharacterDetails() -> CharacterDetailCell.Model
    func getEpisode(at index: Int) -> EpisodeHeaderCell.CellModel
    func numberOfEpisodes() -> Int
    func getEpisodeCharacters(at index: Int) -> [Character]?
}

class CharacterDetailImplementation: CharacterDetailPresenter {
    
    weak var view: CharacterDetailViewProtocol?
    var characterManager: CharacterDetailDataManager
    
    
    init(manager: CharacterDetailDataManager) {
        self.characterManager = manager
    }

    
    func viewDidLoad() {
        characterManager.fechEpisodes { result in
            switch result {
            case .success(let episodes):
                self.view?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCharacterDetails() -> CharacterDetailCell.Model {
        let characterModel = characterManager.getCharacterModel()
        return characterModel
    }
    
    func getEpisode(at index: Int) -> EpisodeHeaderCell.CellModel {
        return characterManager.getEpisodeModel(at: index)
    }
    
    func numberOfEpisodes() -> Int {
        return characterManager.numberOfEpisodes()
    }
    
    func getEpisodeCharacters(at index: Int) -> [Character]? {
        if let characters = characterManager.getEpisodeCharactersData(at: index - 1) {
            return characters
        }else {
            characterManager.fetchEpisodeCharacters(at: index - 1) {
                self.view?.updateSection(at: index)
            }
            return nil
        }
    }
}
