//
//  RMEpisodeRoute.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 20/07/22.
//

import Foundation

protocol URLCompleteEpisodes {
    var finalURL: String {get}
    var urlRequestComplete: URLRequest {get}
}
protocol RMFilterEpisodesProtocol {
    var filterTupe : (String, String) {get}
}
enum RMpisodesRoute: URLCompleteEpisodes {
    static let domain = "https://rickandmortyapi.com/api"
    case getAllEpisodes
    case getASingleEpisode(episodeId: Int)
    case getMultipleEpisodes(episodes: [Int])
    case filterEpisodes(filteraBy: [RMFilterEpisodesProtocol])
}
extension RMpisodesRoute {
    var finalURL: String {
        var compound = URLComponents()
        switch self {
        case .getAllEpisodes:
            compound.path = "/episode"
            return compound.string ?? ""
        case .getASingleEpisode(let episodeId):
            guard episodeId > 0 else {
                print("no hay un episodio menor a 1")
                compound.path = "/episode/1"
                return compound.string ?? ""
            }
            compound.path = "/episode/\(episodeId)"
            return compound.string ?? ""
        case .getMultipleEpisodes(let episodes):
            let mapingArray = episodes.map({String($0)})
            let joining = mapingArray.joined(separator: ",")
            compound.path = "/episode/\(joining)"
            return compound.string ?? ""
        case .filterEpisodes(let filteraBy):
            var mapping = filteraBy.map({URLQueryItem(name: $0.filterTupe.0.lowercased() , value: $0.filterTupe.1.lowercased())})
            compound.queryItems = mapping
            compound.path = "/episode/"
            return compound.string ?? ""
        }
    }
}
extension RMpisodesRoute {
    var urlRequestComplete: URLRequest {
        let urlCompletada = Self.domain + self.finalURL
        let url = URL(string: urlCompletada)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
struct RMNameRouteEpisode: RMFilterEpisodesProtocol {
    var name: String
}
extension RMNameRouteEpisode {
    var filterTupe: (String, String) {
        return ("name", name)
    }
}
struct RMEpisodeFilter: RMFilterEpisodesProtocol {
    var episode: String
}
extension RMEpisodeFilter {
    var filterTupe: (String, String) {
        return ("episode", episode)
    }
}
