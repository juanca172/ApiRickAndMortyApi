//
//  RMResponses.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation



struct ResponseHelper <RMType: Decodable>: Decodable {
    
    struct Info: Codable {
        var count: Int
        var pages: Int
        var next: String?
        var prev: String?
    }
    
    var info: Info
    var results: [RMType]
}

