//
//  CharacterDetailConfigurator.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 25/7/23.
//

import UIKit

class CharacterDetailViewConfigurator {
    let character: Character
    
    init(with character: Character) {
        self.character = character
    }
    
    func createCharacterDetailViewController(viewController: CharacterDetailViewController)  {
        let manager = CharacterDetailDataManager(character: character)
        let router = CharacterListViewRouter(with: viewController)
        let presenter: CharacterDetailPresenter = CharacterDetailImplementation(manager: manager, router: router)
        viewController.presenter = presenter
        presenter.view = viewController
    }
}
