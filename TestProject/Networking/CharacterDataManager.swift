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
    func getCharacterModel(at index: Int) -> CharacterCell.CellModel
    func getCharacterDetails(at index: Int) -> CharacterDetailCell.CellModel
}

class CharacterDataManager: CharacterDataManagerProtocol {

    var characters: [Character] = []
    let apiClient = RickAndMortyAPIManager()
    
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
    
    func getCharacterModel(at index: Int) -> CharacterCell.CellModel{
        let character = characters[index]
        return .init(name: character.name,
                     status: character.status,
                     image: character.image)
    }
    
    func getCharacterDetails(at index: Int) -> CharacterDetailCell.CellModel {
        let character =  characters[0]
        let cellModel = CharacterDetailCell.CellModel.init(name: character.name, status: character.status, species: character.species, gender: character.gender, image: character.image, location: "")
        return cellModel
    }
}
