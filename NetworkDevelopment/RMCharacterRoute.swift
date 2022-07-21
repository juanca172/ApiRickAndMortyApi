//
//  RMCharacterRoute.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import Foundation
import UIKit
protocol UrlCompleteCharacter {
    var finalUrl: String {get}
    var URLRequestComplete : URLRequest {get}
}
enum RMCharacterRoute  : UrlCompleteCharacter {
    static var dominio = "https://rickandmortyapi.com/api"
    case getAllCharacter
    case getOneCharacter(id: Int)
    case getMultipleCharacters(ids:[Int])
    case getPageCharacter(pageNumber : Int)
    case filterCharacter(filterProtocol: [RMFilterCharacterProtocol])
}
extension RMCharacterRoute {
    var finalUrl: String {
        var components = URLComponents()
        switch self {
        case .getAllCharacter:
            components.path = "/character"
            return components.string  ?? ""
        case .getOneCharacter(let value):

            guard value >= 1 else {
                print ("No existe ningun personaje con esa id")
                components.path = "/character/1"
                return components.string ?? ""
            }
            components.path = "/character/\(value)"
            return components.string ?? ""
            
        case .getMultipleCharacters(ids: let values):
            
            var value = values.map({String($0)})
            var result = value.joined(separator: ",")
            components.path = "/character/\(result)"
            return components.string ?? ""
            
        case .getPageCharacter(pageNumber: let page):
            
            guard page >= 1 else {
                print ("No existe ninguna pagina antes de la pagina 1")
                components.path = "/character/"
                let queryToken = URLQueryItem(name: "page", value: "1")
                components.queryItems = [queryToken]
                return components.string ?? ""
            }
            components.path = "/character/"
            let queryToken = URLQueryItem.init(name: "page", value: "\(page)")
            components.queryItems = [queryToken]
            return components.string ?? ""
            
        case .filterCharacter(filterProtocol: let arrayFilter):
            let mapingAndQueryng = arrayFilter.map({URLQueryItem(name: $0.value.0.lowercased(), value: $0.value.1.lowercased())})
            components.queryItems = mapingAndQueryng
            components.path = "/character/"
            return components.string ?? ""
        }
    }
}

extension RMCharacterRoute {
    var URLRequestComplete: URLRequest {
        let buildingUrl: String = Self.dominio + finalUrl
        if let urlCompound = URL(string: buildingUrl) {
            return URLRequest.init(url:urlCompound)
        }
        return URLRequest(url:URL(string: buildingUrl)!)

    }
}
protocol RMFilterCharacterProtocol {
    var value: (String, String) {get}
}
struct RMNameCharacter: RMFilterCharacterProtocol {
    let name: String
}
extension RMNameCharacter {
    var value: (String, String) {
        return ("name", name)
    }
}

struct RMStatusCharacter: RMFilterCharacterProtocol {
    let status: TypesOfStatus.RawValue
}
extension RMStatusCharacter {
    var value: (String, String) {
        return ("status", status)
    }
}

struct RMEspecieCharacter: RMFilterCharacterProtocol {
    let specie: String
}
extension RMEspecieCharacter {
    var value: (String, String) {
        return ("specie", specie)
    }
}
struct RMGeneroCharacter: RMFilterCharacterProtocol {
    let genre: TypesOfGenres.RawValue
}
extension RMGeneroCharacter {
    var value: (String, String) {
        return ("genre", genre)
    }
}
enum TypesOfStatus: String{
    case alive
    case dead
    case unknown
}
enum TypesOfGenres: String {
    case female
    case male
    case genderless
    case unknown
}
 
