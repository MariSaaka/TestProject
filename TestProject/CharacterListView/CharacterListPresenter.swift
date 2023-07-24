//
//  CharactersViewModel.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import UIKit

protocol CharacterListPresenter {
    var view: CharacterListViewProtocol? { get set }
    func viewDidLoad()
    func numberOfCharacters() -> Int
    func getCharacterInfo(at index: IndexPath) -> Character
    func getCharacterImage(at index: IndexPath) -> UIImage
    func fetchMoreList()
    func showCharacterDetails()
}


class CharacterListImplementation: CharacterListPresenter {

    private var characters: [Character] = []
    private var characterImages: [UIImage] = []
    weak var view: CharacterListViewProtocol?
    var characterManager: CharacterDataManager
    
    
    init(manager: CharacterDataManager) {
        self.characterManager = manager
    }
    
    func viewDidLoad() {
        characterManager.startFetchData { result in
            switch result {
            case .success(let characters):
                self.characters = characters
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCharacterInfo(at index: IndexPath) -> Character {
        return characters[index.row]
    }
    
    func getCharacterImage(at index: IndexPath) -> UIImage {
        var resultImage: UIImage?
        let characterImage = characters[index.row].image
        self.characterManager.downloadImage(string: characterImage) { result in
            switch result {
            case .success(let image):
                resultImage = image
                print("Image downloaded successfully.")
            case .failure(let error):
                print(error)
            }
        }
        return resultImage ?? UIImage(systemName: "heart.fill")!
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    
    func fetchMoreList() {
        self.view?.updateList()
    }
    
    func showCharacterDetails() {
        
    }
}
