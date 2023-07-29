//
//  EpisodesAPIManager.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 28/7/23.
//

import Foundation

class EpisodesAPIManager {
    let group = DispatchGroup()

    func fetchEpisodes(episodes: [String], completion: @escaping (Result<[Episode], APIError>) -> Void) {
        var resultArray: [Episode] = []

        episodes.forEach { episode in
            let url = URL(string: episode)
            guard let url else { return }
            fetch(with: url) { result in
                switch result {
                case .success(let episode):
                    resultArray.append(episode)
                case .failure(let error):
                    print(error)
                }
            }
        }
        group.notify(queue: .global()) {
            completion(.success(resultArray))
        }
    }

    func fetch(with url: URL, completion: @escaping ((Result<Episode, APIError>) -> Void)) {
            self.group.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    self.group.leave()
                }
                guard let data = data, error == nil else {
                    completion(.failure(.errorDecode))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Episode.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.errorDecode))
                }
            }.resume()
    }
}

//class EpisodesAPIManager {
//    func fetchEpisodes(episodes: [String], completion: @escaping (Result<[Episode], APIError>) -> Void) {
//        Task {
//            do {
//                var resultArray: [Episode] = []
//                try await withThrowingTaskGroup(of: Episode.self) { group in
//                    for episodeURL in episodes {
//                        guard let url = URL(string: episodeURL) else {
//                            throw APIError.invalidUrl
//                        }
//                        group.addTask { try await self.fetch(with: url) }
//                    }
//                    for try await episode in group {
//                        resultArray.append(episode)
//                    }
//                }
//                completion(.success(resultArray))
//            } catch {
//                completion(.failure(.unknownError))
//            }
//        }
//    }
//
//    func fetch(with url: URL) async throws -> Episode {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        return try decoder.decode(Episode.self, from: data)
//    }
//}
