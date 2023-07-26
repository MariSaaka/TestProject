//
//  RickAndMortyAPIClient.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import UIKit

enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}

class RickAndMortyAPIManager {
    
    var session: URLSessionDataTask?
    
    func fetchCharacters(with page: Int, completion: @escaping ((Result<Characters, APIError>) -> Void)) {
        guard session == nil else { return }
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.errorDecode))
                self.session = nil
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Characters.self, from: data)
                self.session = nil
                completion(.success(response))
            } catch {
                self.session = nil
                completion(.failure(.errorDecode))
            }
        }
        session?.resume()
    }
}
