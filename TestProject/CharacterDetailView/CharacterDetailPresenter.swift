//
//  CharacterDetailPresenter.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 24/7/23.
//

import Foundation

protocol CharacterDetailPresenter {
    var view: CharacterDetailViewProtocol? { get set }
    func getCharacterDetails() -> CharacterDetailCell.Model
    func getEpisodes() -> [String]
}

class CharacterDetailImplementation: CharacterDetailPresenter {
    weak var view: CharacterDetailViewProtocol?
    var characterManager: CharacterDetailDataManager
    
    
    init(manager: CharacterDetailDataManager) {
        self.characterManager = manager
    }

    func getCharacterDetails() -> CharacterDetailCell.Model {
        let characterModel = characterManager.getCharacterModel()
        return characterModel
    }
    
    func getEpisodes() -> [String] {
        return characterManager.getEpisodes()
    }
    
}
