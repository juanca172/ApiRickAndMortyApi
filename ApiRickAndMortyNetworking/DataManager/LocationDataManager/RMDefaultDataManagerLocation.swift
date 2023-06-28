//
//  RMDefaultDataManagerLocation.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

struct RMDefaultDataManagerLocation: RMDataManager {
    typealias T = RMLocation
    
    var networKProvider: NetworkProviderProtocol
    
    init(networKProvider: NetworkProviderProtocol) {
        self.networKProvider = networKProvider
    }
}

extension RMDefaultDataManagerLocation: RMLocationDataManagerProtocol {
    func getAllLocations<T>(request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getAll(request: request) { (result:Result<ResponseHelper<RMLocation>, RMError>) in
            switch result {
            case.success(let locations):
                if let fetchedLocations = locations.results as? [T] {
                    complition(.success(fetchedLocations))
                }
            case.failure(let error) :
                complition(.failure(error))
            }
        }
    }
    
    func getASingleLocation<T>(id: Int, request: URLRequest, complition: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        self.getOne(request: request) { (result: Result<RMLocation, RMError>) in
            switch result {
            case.success(let location):
                if let fetchedLocation = location as? T {
                    complition(.success(fetchedLocation))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getMultipleLocations<T>(ids: [Int], request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getMultiple(request: request) { (result: Result<[RMLocation], RMError>) in
            switch result {
            case.success(let locations):
                if let fetchedLocations = locations as? [T] {
                    complition(.success(fetchedLocations))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getPageLocation<T>(page: Int, request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getPage(request: request) { (result: Result<ResponseHelper<RMLocation>, RMError>) in
            switch result {
            case.success(let locations):
                if let fetchedLocations = locations.results as? [T] {
                    complition(.success(fetchedLocations))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getFilterLocations<T>(request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.filterData(request: request) { (result: Result<ResponseHelper<RMLocation>, RMError>) in
            switch result {
            case.success(let locations):
                if let fectchedLocations = locations.results as? [T] {
                    complition(.success(fectchedLocations))
                }
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    
}
