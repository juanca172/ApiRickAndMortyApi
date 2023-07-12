//
//  RMCharacterRoute.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import Foundation
import UIKit

enum RMCharacterRoute  : URLComplete {
    static var dominio = "https://rickandmortyapi.com/api"
    case getAllCharacter
    case getOneCharacter(id: Int)
    case getMultipleCharacters(ids:[Int])
    case getPageCharacter(pageNumber : Int)
    case filterCharacter(filterProtocol: [RMFilterProtocol])
}
extension RMCharacterRoute {
    var finalURL: String {
        var components = URLComponents()
        switch self {
        case .getAllCharacter:
            components.path = "/character"
            return components.string  ?? ""
        case .getOneCharacter(let value):
            assert(value > 0 , "no existe un personaje con esa id: \(value)")
            components.path = "/character/\(value)"
            return components.string ?? ""
            
        case .getMultipleCharacters(ids: let values):
            
            let value = values.map({String($0)})
            let result = value.joined(separator: ",")
            components.path = "/character/\(result)"
            return components.string ?? ""
            
        case .getPageCharacter(pageNumber: let page):
            
            assert(page > 0, "La pagina \(page) no existe")
            components.path = "/character/"
            let queryToken = URLQueryItem.init(name: "page", value: "\(page)")
            components.queryItems = [queryToken]
            return components.string ?? ""
            
        case .filterCharacter(filterProtocol: let arrayFilter):
            let mapingAndQueryng = arrayFilter.map({URLQueryItem(name: $0.filterTuple.0.lowercased(), value: $0.filterTuple.1.lowercased())})
            components.queryItems = mapingAndQueryng
            components.path = "/character/"
            return components.string ?? ""
        }
    }
}

extension RMCharacterRoute {
    var urlRequestComplete: URLRequest {
        let buildingUrl: String = Self.dominio + finalURL
        if let urlCompound = URL(string: buildingUrl) {
            return URLRequest.init(url:urlCompound)
        }
        return URLRequest(url:URL(string: buildingUrl)!)

    }
}

struct RMNameCharacter {
    let name: String
}
extension RMNameCharacter : RMFilterProtocol {
    var filterTuple: (String, String) {
        return ("name", name)
    }
}

struct RMStatusCharacter {
    let status: RMCharacterStatus.RawValue
}
extension RMStatusCharacter : RMFilterProtocol{
    var filterTuple: (String, String) {
        return ("status", status)
    }
}

struct RMEspecieCharacter {
    let specie: String
}
extension RMEspecieCharacter : RMFilterProtocol {
    var filterTuple: (String, String) {
        return ("specie", specie)
    }
}
struct RMGeneroCharacter {
    let genre: RMCharacterGender.RawValue
}
extension RMGeneroCharacter : RMFilterProtocol {
    var filterTuple: (String, String) {
        return ("genre", genre)
    }
}

