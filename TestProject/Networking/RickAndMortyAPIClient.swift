//
//  RickAndMortyAPIClient.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import UIKit

class RickAndMortyAPIClient {
    var url = URL(string: "https://rickandmortyapi.com/api/character")!
    
    func fetchCharacters(completion: @escaping ((Result<[Character], Error>) -> Void)) {
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
    
    
    func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "ImageDownloadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to UIImage."])))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
}
