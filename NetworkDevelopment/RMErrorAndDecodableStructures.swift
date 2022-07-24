//
//  RMErrorAndDecodableStructures.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 23/07/22.
//

import Foundation

struct DatosAppi: Decodable{
    var characters: String
    var locations: String
    var episodes: String
}

struct ApiResponseCharacter: Decodable {
    var info: DatosInfo
    var results: [DatosCharacter]
}
struct ApiResponseLocation: Decodable {
    var info: DatosInfo
    var results: [DatosLocation]
}
struct ApiResponseEpisode: Decodable {
    var info: DatosInfo
    var results: [DatosEpisodios]
}
struct DatosInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
struct DatosCharacter: Decodable {
    var id : Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender : String
    var image: String
}
struct DatosLocation : Decodable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
}
struct DatosEpisodios: Decodable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
}


enum RMError: Error  {
    case datosNotFound
    case networkError(Error)
    case imposibleDecodiar
}
extension RMError : Equatable {
    static func == (lhs: RMError, rhs: RMError) -> Bool {
        switch (lhs, rhs) {
        case (datosNotFound,datosNotFound):
            return true
        case(imposibleDecodiar, imposibleDecodiar):
            return true
        case (networkError(let error1), networkError(let error2)):
            return "\(error1)" == "\(error2)"
        default:
            return false
        }
    }
}
