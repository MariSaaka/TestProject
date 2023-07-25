//
//  RickAndMortyAPIClient.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import UIKit

class RickAndMortyAPIClient {
    func fetchCharacters(with url: URL, completion: @escaping ((Result<[Character], Error>) -> Void)) {
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badURL)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Characters.self, from: data)
                completion(.success(response.charactersResults))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
