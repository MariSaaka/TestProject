//
//  Characters.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 22/7/23.
//

import Foundation


struct Characters: Codable {
    let charactersResults: [Character]
    
    enum CodingKeys: String, CodingKey {
        case charactersResults = "results"
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
//    let location: Location
    let episodes: [String]
    let url: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case gender = "gender"
        case image = "image"
//        case location = "location"
        case episodes = "episode"
        case url = "url"
    }
}


//struct Location: Codable {
//    let name: String
//    let url: URL
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case url = "url"
//    }
//}
