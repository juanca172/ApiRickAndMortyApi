//
//  EpisodeDataManger.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation

struct RMEpisodeDataManger: RMDataManager {
    typealias T = RMEpisode
    
    var networKProvider: NetworkProviderProtocol
    
    init(networKProvider: NetworkProviderProtocol) {
        self.networKProvider = networKProvider
    }
}

extension RMEpisodeDataManger: RMEpisodeDatamangerProtocol {
    
    func getAllEpisodes<T>(request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getAll(request: request) { (result: Result<ResponseHelper<RMEpisode>, RMError>) in
            switch result {
            case .success(let response):
                if let result = response.results as? [T] {
                    complition(.success(result))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getASingleEpisode<T>(id: Int, request: URLRequest, complition: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        self.getOne(request: request) { (result: Result<RMEpisode, RMError>) in
            switch result {
            case.success(let episode):
                if let episode = episode as? T {
                    complition(.success(episode))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getMultipleEpisodes<T>(ids: [Int], request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getMultiple(request: request) { (result: Result<[RMEpisode], RMError>) in
            switch result {
            case.success(let episodes):
                if let episod = episodes as? [T] {
                    complition(.success(episod))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getPageEpisode<T>(page: Int, request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getPage(request: request) { (result: Result<ResponseHelper<RMEpisode>, RMError>) in
            switch result {
            case.success(let response):
                if let episodes = response.results as? [T] {
                    complition(.success(episodes))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getFilterEpisodes<T>(request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.filterData(request: request) { (result: Result<ResponseHelper<RMEpisode>, RMError>) in
            switch result {
            case.success(let response):
                if let episodes = response.results as? [T] {
                    complition(.success(episodes))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    
}
