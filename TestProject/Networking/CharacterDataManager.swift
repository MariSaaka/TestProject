//
//  CharacterDataManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 23/7/23.
//

import UIKit

protocol CharacterDataManagerProtocol {
    func startFetchData(handler: @escaping  ((Result<[Character], Error>) -> Void))
    func downloadImage(string: String, handler: @escaping ((Result<UIImage, Error>) -> Void))
}

class CharacterDataManager: CharacterDataManagerProtocol {
   
    
    let apiClient = RickAndMortyAPIClient()
    
    func startFetchData(handler: @escaping ((Result<[Character], Error>) -> Void)) {
        apiClient.fetchCharacters { result in
            handler(result)
        }
    }
    
    func downloadImage(string: String, handler: @escaping ((Result<UIImage, Error>) -> Void)) {
        apiClient.downloadImage(from: string) { result in
            handler(result)
        }
    }
}
