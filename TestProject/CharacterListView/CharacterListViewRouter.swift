//
//  CharacterListViewRouter.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 26/7/23.
//

import UIKit

protocol CharacterListViewRouterProtocol {
    func navigateToCharacterDetailPage(character: Character)
}

class CharacterListViewRouter: CharacterListViewRouterProtocol {
    weak var controller: UIViewController?
    
    init(with controller: UIViewController) {
        self.controller = controller
    }
    
    func navigateToCharacterDetailPage(character: Character) {
        let configurator = CharacterDetailViewConfigurator(with: character)
        let viewController = CharacterDetailViewController(with: configurator)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }
}
