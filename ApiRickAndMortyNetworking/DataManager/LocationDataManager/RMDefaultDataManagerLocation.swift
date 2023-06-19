//
//  RMDefaultDataManagerLocation.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

class RMDefaultDataManagerLocation: RMLocationDataManagerProtocol {
    
    let networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func getAllLocations(complition: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.getAllLocations.urlRequestComplete
        networkProvider.getData(urlRequest: request) {(result: Result <ResponseHelper, RMError>) in
            switch result {
            case.success(let locations):
                complition(.success(locations.results))
            case.failure(let error) :
                complition(.failure(error))
            }
        }
    }
    
    func getASingleLocation(id: Int, complition: @escaping (Result<RMLocation, Error>) -> Void) {
        let request = RMLocationRoute.getASingleLocation(id: id).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<RMLocation, RMError>) in
            switch result {
            case.success(let location):
                complition(.success(location))
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getMultipleLocations(ids: [Int], complition: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.getMultipleLocations(ids: ids).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper, RMError>) in
            switch result {
            case.success(let locations):
                complition(.success(locations.results))
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func getPageLocation (page: Int, complition: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.getPageIndicated(page: page).urlRequestComplete
        print(request)
        networkProvider.getData(urlRequest: request) { (result:Result<ResponseHelper, RMError>) in
            switch result {
            case.success(let locations):
                complition(.success(locations.results))
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }


    func getFilterLocations(filters: [RMFilterProtocol], complition: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.filterLocation(filterProtocol: filters).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper, RMError>) in
            switch result {
            case.success(let locations):
                complition(.success(locations.results))
            case.failure(let error):
                complition(.failure(error))
            }
         }
    }
    
    
}
