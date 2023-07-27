//
//  CharacterDataManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

protocol CharacterDataManagerProtocol {
    func startFetchData(with page: Int, handler: @escaping  ((Result<Characters, APIError>) -> Void))
    func numberOfCharacters() -> Int
    func getCharacterModel(at index: Int) -> CharacterCell.CellModel
    func getCharacterForNavigation(at index: Int, is filtered: Bool) -> Character
    func getMaxNumberOfpages() -> Int
    func filterContentForSearchText(searchText: String, handler: () -> Void )
    func numberOfFilteredCharacters() -> Int
}

class CharacterDataManager: CharacterDataManagerProtocol {

    let apiClient = RickAndMortyAPIManager()
    var characters: [Character] = []
    var filteredCharacters: [Character] = []
    var pagesNumber: Int = 0
    
    func startFetchData(with page: Int, handler: @escaping ((Result<Characters, APIError>) -> Void)) {
        apiClient.fetchCharacters(with: page) { result in
            switch result {
            case .success(let response):
                self.characters.append(contentsOf: response.charactersResults)
                self.pagesNumber = response.info.pages
            case .failure(let error):
                print(error)
            }
            handler(result)
        }
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func getCharacterModel(at index: Int) -> CharacterCell.CellModel {
        let character = characters[index]
        return .init(name: character.name,
                     status: character.status,
                     image: character.image)
    }
    
    func getMaxNumberOfpages() -> Int {
        return pagesNumber
    }
    
    func getCharacterForNavigation(at index: Int, is filtered: Bool) -> Character {
        let character = filtered ? filteredCharacters[index] : characters[index]
        return character
    }
    
    func filterContentForSearchText(searchText: String, handler: () -> Void) {
        filteredCharacters = characters.filter {
            (character: Character) -> Bool in
            return character.name.lowercased().contains(searchText.lowercased())
        }
        handler()
    }
    
    func numberOfFilteredCharacters() -> Int {
        return filteredCharacters.count
    }
    
    func getFilteredCharacterModel(at index: Int) -> CharacterCell.CellModel {
        let filteredCharacter = filteredCharacters[index]
        return .init(name: filteredCharacter.name,
                     status: filteredCharacter.status,
                     image: filteredCharacter.image)
    }
}
