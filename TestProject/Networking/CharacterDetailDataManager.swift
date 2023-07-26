//
//  CharacterDetailDataManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 26/7/23.
//

import Foundation

protocol CharacterDetailDataManagerProtocol {
    func getCharacterModel() -> CharacterDetailCell.CellModel
    func getEpisodes() -> [String]
}

class CharacterDetailDataManager: CharacterDetailDataManagerProtocol {
   
    var character: Character
    var episodes: [String]  = []
    
    init(character: Character) {
        self.character = character
    }
    
    func getCharacterModel() -> CharacterDetailCell.CellModel {
        return .init(name: character.name,
                     status: character.status,
                     species: character.species,
                     gender: character.gender,
                     image: character.image,
                     location: character.location.name)
    }
    
    func getEpisodes() -> [String] {
        return character.episodes
    }
}
