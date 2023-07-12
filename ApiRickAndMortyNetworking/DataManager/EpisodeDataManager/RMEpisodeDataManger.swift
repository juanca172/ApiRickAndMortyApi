//
//  EpisodeDataManger.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation

struct RMEpisodeDataManger {
    var networKProvider: NetworkProviderProtocol
    let dataManager: RMDataManager<RMEpisode>
    
    init(networKProvider: NetworkProviderProtocol) {
        self.networKProvider = networKProvider
        self.dataManager = RMDataManager(networKProvider: networKProvider)
    }
}

extension RMEpisodeDataManger: RMEpisodeDatamangerProtocol {
    
    func getASingleEpisode(id: Int, completion: @escaping (Result<RMEpisode, Error>) -> Void) {
        let request = RMEpisodesRoute.getASingleEpisode(episodeId: id).urlRequestComplete
        dataManager.getOne(request: request) { (result: Result<RMEpisode, RMError>) in
            switch result {
            case.success(let episode):
                completion(.success(episode))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMultipleEpisodes(ids: [Int], completion: @escaping (Result<[RMEpisode], Error>) -> Void) {
        let request = RMEpisodesRoute.getMultipleEpisodes(episodes: ids).urlRequestComplete
        dataManager.getMultiple(request: request) { (result: Result<[RMEpisode], RMError>) in
            switch result {
            case.success(let episodes):
                completion(.success(episodes))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPageEpisode(page: Int, completion: @escaping (Result<[RMEpisode], Error>) -> Void) {
        let request = RMEpisodesRoute.getEpisodePage(page: page).urlRequestComplete
        dataManager.getPage(request: request) { (result: Result<ResponseHelper<RMEpisode>, RMError>) in
            switch result {
            case.success(let response):
                completion(.success(response.results))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilterEpisodes(filterParams: [RMFilterProtocol], completion: @escaping (Result<[RMEpisode], Error>) -> Void) {
        let request = RMEpisodesRoute.filterEpisodes(filteraBy: filterParams).urlRequestComplete
        dataManager.filterData(request: request) { (result: Result<ResponseHelper<RMEpisode>, RMError>) in
            switch result {
            case.success(let response):
                completion(.success(response.results))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
