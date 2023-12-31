//
//  CharactersViewModel.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import Foundation

protocol CharacterListPresenter {
    var view: CharacterListViewProtocol? { get set }
    var router: CharacterListViewRouter? { get set }
    func viewDidLoad()
    func numberOfCharacters() -> Int
    func getCharacterInfo(at index: Int) -> CharacterCell.CellModel
    func fetchMoreCharacters()
    func fetchMoreList(with page: Int)
    func showCharacter(at index: Int, is filtered: Bool)
    func filterContentForSearchText(searchText: String)
    func numberOfFilteredCharacters() -> Int
    func getFilteredCharacterModel(at index: Int) -> CharacterCell.CellModel
}


class CharacterListImplementation: CharacterListPresenter {
 
    weak var view: CharacterListViewProtocol?
    var characterManager: CharacterDataManager
    var router: CharacterListViewRouter?
    var lastPage: Int = 1
    
    
    init(manager: CharacterDataManager) {
        self.characterManager = manager
    }
    
    func viewDidLoad() {
        fetchMoreList(with: lastPage)
    }
    
    func numberOfCharacters() -> Int {
        return characterManager.numberOfCharacters()
    }
    
    func getCharacterInfo(at index: Int) -> CharacterCell.CellModel {
        return characterManager.getCharacterModel(at: index)
    }
    
    func fetchMoreCharacters() {
        let maxPages = characterManager.getMaxNumberOfpages()
        if self.lastPage < maxPages {
            self.lastPage += 1
            fetchMoreList(with: lastPage)
        }else {
            view?.disappearSpinnerView()
        }
    }
    
    func fetchMoreList(with page: Int) {
        characterManager.startFetchData(with: page) { result in
            switch result {
            case .success(_ ):
                self.view?.updateList()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showCharacter(at index: Int, is filtered: Bool) {
        let character = characterManager.getCharacterForNavigation(at: index, is: filtered)
        self.router?.navigateToCharacterDetailPage(character: character)
    }
    
    func filterContentForSearchText(searchText: String) {
         characterManager.filterContentForSearchText(searchText: searchText) {
            view?.updateList()
        }
    }
    
    func numberOfFilteredCharacters() -> Int {
        return characterManager.numberOfFilteredCharacters()
    }
    
    func getFilteredCharacterModel(at index: Int) -> CharacterCell.CellModel {
        return characterManager.getFilteredCharacterModel(at: index)
    }
}
