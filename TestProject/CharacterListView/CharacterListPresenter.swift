//
//  CharactersViewModel.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import Foundation

protocol CharacterListPresenter {
    var view: CharacterListViewProtocol? { get set }
    func viewDidLoad(with url: URL)
    func numberOfCharacters() -> Int
    func getCharacterInfo(at index: IndexPath) -> CharacterCell.CellModel
    func fetchMoreList()
    func showCharacterDetails()
}


class CharacterListImplementation: CharacterListPresenter {
    
    weak var view: CharacterListViewProtocol?
    var characterManager: CharacterDataManager
    
    
    init(manager: CharacterDataManager) {
        self.characterManager = manager
    }
    
    func viewDidLoad(with url: URL) {
        characterManager.startFetchData(with: url) { result in
            switch result {
            case .success(_ ):
                self.view?.updateList()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCharacterInfo(at index: IndexPath) -> CharacterCell.CellModel {
        return characterManager.getCharacterModel(at: index)
    }
    
    func numberOfCharacters() -> Int {
        return characterManager.numberOfCharacters()
    }
    
    func fetchMoreList() {
        self.view?.updateList()
    }
    
    func showCharacterDetails() {
        
    }
}
