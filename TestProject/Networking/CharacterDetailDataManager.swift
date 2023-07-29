//
//  CharacterDetailDataManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 26/7/23.
//

import Foundation

protocol CharacterDetailDataManagerProtocol {
    func getCharacterModel() -> CharacterDetailCell.CellModel
    func fechEpisodes(handler: @escaping ((Result<[Episode], APIError>) -> Void))
    func numberOfEpisodes() -> Int
    func getEpisodeModel(at index: Int) -> EpisodeHeaderCell.CellModel
}

class CharacterDetailDataManager: CharacterDetailDataManagerProtocol {
    let api = EpisodesAPIManager()
    var character: Character
    var episodes: [String]  = []
    var episodesArray: [Episode] = []
    var numOfEpisodes = 0
    
    
    init(character: Character) {
        self.character = character
        self.episodes = character.episodes
    }
    
    func getCharacterModel() -> CharacterDetailCell.CellModel {
        return .init(name: character.name,
                     status: character.status,
                     species: character.species,
                     gender: character.gender,
                     image: character.image,
                     location: character.location.name)
    }
    
    
    func fechEpisodes(handler: @escaping ((Result<[Episode], APIError>) -> Void)) {
        api.fetchEpisodes(episodes: episodes) { result in
            switch result {
            case.success(let episodes):
                self.episodesArray = episodes
                self.numOfEpisodes = self.episodesArray.count
                print(episodes)
            case .failure(let error):
                print(error)
            }
            handler(result)
        }
    }
    
    func numberOfEpisodes() -> Int {
        return self.numOfEpisodes
    }
    
    func getEpisodeModel(at index: Int) -> EpisodeHeaderCell.CellModel {
        let episode = episodesArray[index]
        return .init(name: episode.name)
    }
}
