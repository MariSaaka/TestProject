//
//  Episode.swift
//  TestProject
//
//  Created by Mariam Saakashvili on 27/7/23.
//

import Foundation


struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case airDate = "air_date"
        case characters = "characters"
    }
}

