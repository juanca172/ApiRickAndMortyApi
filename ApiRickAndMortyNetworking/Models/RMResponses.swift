//
//  RMResponses.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct CharacterResponseHelper: Decodable {
    var info: Info
    var results: [RMCharacter]
    init(results: [RMCharacter], info: Info) {
        self.info = info 
        self.results = results
    }
}

struct LocationResponseHelper: Decodable {
    var info: Info
    var results: [RMLocation]
}

struct EpisodeResponseHelper: Decodable {
    var info: Info
    var results: [RMEpisode]
}

