//
//  CharacterListViewConfiguration.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import Foundation

class CharacterListViewConfigurator {
    func createInitialViewController() -> CharacterListViewController {
        let manager = CharacterDataManager()
        var presenter: CharacterListPresenter = CharacterListImplementation(manager: manager)
        let initialViewController = CharacterListViewController(presenter: presenter)
        presenter.view = initialViewController
        return initialViewController
    }
    
}


