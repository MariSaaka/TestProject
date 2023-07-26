//
//  CharacterDetailConfigurator.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 25/7/23.
//

import Foundation

class CharacterDetailViewConfigurator {
    let character: Character
    
    init(with character: Character) {
        self.character = character
    }
    
    func createCharacterDetailViewController() -> CharacterDetailViewController {
        let manager = CharacterDetailDataManager()
        var presenter: CharacterDetailPresenter = CharacterDetailImplementation(manager: manager)
        let detailViewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = detailViewController
        return detailViewController
    }
}
