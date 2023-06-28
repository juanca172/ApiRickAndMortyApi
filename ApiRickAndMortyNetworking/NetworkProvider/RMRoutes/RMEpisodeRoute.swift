//
//  RMEpisodeRoute.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 20/07/22.
//

import Foundation


enum RMEpisodesRoute: URLComplete {
    static let domain = "https://rickandmortyapi.com/api"
    case getAllEpisodes
    case getEpisodePage(page: Int)
    case getASingleEpisode(episodeId: Int)
    case getMultipleEpisodes(episodes: [Int])
    case filterEpisodes(filteraBy: [RMFilterProtocol])
}
extension RMEpisodesRoute {
    var finalURL: String {
        
        var compound = URLComponents()
        switch self {
        case .getAllEpisodes:
            compound.path = "/episode"
            return compound.string ?? ""
        case .getASingleEpisode(let episodeId):
            assert(episodeId > 0, "No existe el episodio \(episodeId)")
            compound.path = "/episode/\(episodeId)"
            return compound.string ?? ""
        case .getMultipleEpisodes(let episodes):
            let mapingArray = episodes.map({String($0)})
            let joining = mapingArray.joined(separator: ",")
            compound.path = "/episode/\(joining)"
            return compound.string ?? ""
        case .filterEpisodes(let filterBy):
            let mapping = filterBy.map({URLQueryItem(name: $0.filterTuple.0.lowercased() , value: $0.filterTuple.1.lowercased())})
            compound.queryItems = mapping
            compound.path = "/episode/"
            return compound.string ?? ""
        case.getEpisodePage(page: let page):
            
            assert(page > 0, "La pagina \(page) no existe")
            compound.path = "/episode"
            let queryToken = URLQueryItem(name: "page", value: "\(page)")
            compound.queryItems = [queryToken]
            return compound.string ?? ""
            
        }
    }
}
extension RMEpisodesRoute {
    var urlRequestComplete: URLRequest {
        let urlCompletada = Self.domain + self.finalURL
        let url = URL(string: urlCompletada)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
struct RMNameRouteEpisode {
    var name: String
}
extension RMNameRouteEpisode : RMFilterProtocol {
    var filterTuple: (String, String) {
        return ("name", name)
    }
}
struct RMEpisodeFilter {
    var episode: String
}
extension RMEpisodeFilter : RMFilterProtocol {
    var filterTuple: (String, String) {
        return ("episode", episode)
    }
}
