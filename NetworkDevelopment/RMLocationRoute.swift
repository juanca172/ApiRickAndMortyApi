//
//  RMLocationRoute.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 15/07/22.
//

import Foundation
protocol URLCompleteLocation {
    var finalURL: String {get}
    var urlRequestComplete: URLRequest {get}
}
protocol RMFilterLocationProtocol {
    var filterTuple : (String, String) {get}
}
enum RMLocationRoute : URLCompleteLocation {
    static var dominio = "https://rickandmortyapi.com/api"
    case getAllLocations
    case getPageIndicated(page: Int)
    case getASingleLocation(id: Int)
    case getMultipleLocations(ids: [Int])
    case filterLocation(filterProtocol: [RMFilterLocationProtocol])
}
extension RMLocationRoute {
    var finalURL: String {
        var components = URLComponents()
        switch self {
        case .getAllLocations:
            components.path = "/location"
            return components.string ?? ""
        case .getPageIndicated(let page):
            guard page > 0 else {
                print("No existe una pagina menor a la primera")
                components.path = "/location/"
                let query = URLQueryItem(name: "page", value: "1")
                components.queryItems = [query]
                return components.string ?? ""
            }
            components.path = "/location/"
            let query = URLQueryItem(name: "page", value: "\(page)")
            components.queryItems = [query]
            return components.string ?? ""
        case .getASingleLocation(let id):
            guard id > 0 else {
                print("No existe ninguna localizacion con esa id")
                components.path = "/location/1"
                return components.string ?? ""
            }
            components.path = "/location/\(id)"
            return components.string ?? ""
        case .getMultipleLocations(let ids):
            let arregloDeStrings = ids.map({String($0)})
            let stringfinal = arregloDeStrings.joined(separator: ",")
            components.path = "/location/\(stringfinal)"
            return components.string ?? ""
        case .filterLocation(let filterProtocol):
            let arrayOfQueryItems = filterProtocol.map({(value: RMFilterLocationProtocol) -> URLQueryItem in
                return URLQueryItem(name: value.filterTuple.0.lowercased(), value: value.filterTuple.1.lowercased())
            })
            components.queryItems = arrayOfQueryItems
            components.path = "/location/"
            return components.string ?? ""
        }
    }
}

extension RMLocationRoute {
    var urlRequestComplete: URLRequest {
        let unirDomainWithFinalUrl = Self.dominio + self.finalURL
        let url = URL(string: unirDomainWithFinalUrl)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}

struct RMNameLocation: RMFilterLocationProtocol {
    let name: String
}
extension RMNameLocation {
    var filterTuple: (String, String) {
        return ("name", name)
    }
}
struct RMTypeLocation: RMFilterLocationProtocol {
    let type: String
}
extension RMTypeLocation {
    var filterTuple: (String, String) {
        return ("type", type)
    }
}
struct RMDimensionLocation: RMFilterLocationProtocol {
    let dimension: String
}
extension RMDimensionLocation {
    var filterTuple: (String, String) {
        return ("dimension", dimension)
    }
}


