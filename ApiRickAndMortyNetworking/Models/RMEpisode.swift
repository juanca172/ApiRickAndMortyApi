//
//  RMEpisodes.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/10/22.
//

import Foundation


struct RMEpisode: Decodable {
    
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
    
}
