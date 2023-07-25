//
//  ImageManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 25/7/23.
//

import UIKit

class ImageManager {
    static func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
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

