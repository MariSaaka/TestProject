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
    func fetchEpisodeCharacters(at index: Int, handler: @escaping () -> Void)
}

class CharacterDetailDataManager: CharacterDetailDataManagerProtocol {
    let api = EpisodesAPIManager()
    var character: Character
    var episodes: [String]  = []
    var episodesArray: [Episode] = []
    var charactersFromEpisodes: [Int: [String]] = [:]
    var episodeCharacters: [Int: [Character]] = [:]
    var numOfEpisodes = 0
    var concurrentQueue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    
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
                episodes.enumerated().forEach { index, episode in
                    self.charactersFromEpisodes[index] = episode.characters
                }
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
    
    func fetchEpisodeCharacters(at index: Int, handler: @escaping () -> Void) {
        let episodeCharacters = charactersFromEpisodes[index]
        guard let episodeCharacters else { return }
        api.fetchEpisodeCharacters(with: episodeCharacters) { result in
            switch result {
            case .success(let characters):
                self.concurrentQueue.async {
                    self.updateDictionary(key: index, value: characters)
                }
                handler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateDictionary(key: Int, value: [Character]) {
        concurrentQueue.async(flags: .barrier) {
            self.episodeCharacters.updateValue(value, forKey: key)
        }
    }
    
    func getEpisodeCharactersData(at index: Int) -> [Character]? {
        guard let characters = episodeCharacters[index]
        else { return nil }
        return characters
    }
}
