//
//  CharacterDataManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

protocol CharacterDataManagerProtocol {
    func startFetchData(with url: URL, handler: @escaping  ((Result<[Character], Error>) -> Void))
    func numberOfCharacters() -> Int
}

class CharacterDataManager: CharacterDataManagerProtocol {

    var characters: [Character] = []
    let apiClient = RickAndMortyAPIClient()
    
    func startFetchData(with url: URL, handler: @escaping ((Result<[Character], Error>) -> Void)) {
        apiClient.fetchCharacters(with: url) { result in
            switch result {
            case .success(let response):
                self.characters = response
            case .failure(let error):
                print(error)
            }
            handler(result)
        }
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func getCharacterModel(at index: IndexPath) -> CharacterCell.CellModel{
        let character = characters[index.row]
        return .init(name: character.name,
                     status: character.status,
                     image: character.image)
    }
}
