//
//  RMDefaultDataManagerLocation.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

struct RMDefaultDataManagerLocation {
    
    let dataManager: RMDataManager<RMLocation>
    var networKProvider: NetworkProviderProtocol
    
    init(networKProvider: NetworkProviderProtocol) {
        self.networKProvider = networKProvider
        self.dataManager = RMDataManager(networKProvider: networKProvider)
    }
}

extension RMDefaultDataManagerLocation: RMLocationDataManagerProtocol {
 
    func getASingleLocation(id: Int, completion: @escaping (Result<RMLocation, Error>) -> Void) {
        let request = RMLocationRoute.getASingleLocation(id: id).urlRequestComplete
        dataManager.getOne(request: request) { (result: Result<RMLocation, RMError>) in
            switch result {
            case.success(let location):
                completion(.success(location))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMultipleLocations(ids: [Int], completion: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.getMultipleLocations(ids: ids).urlRequestComplete
        dataManager.getMultiple(request: request) { (result: Result<[RMLocation], RMError>) in
            switch result {
            case.success(let locations):
                completion(.success(locations))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPageLocation(page: Int, completion: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.getPageIndicated(page: page).urlRequestComplete
        dataManager.getPage(request: request) { (result: Result<ResponseHelper<RMLocation>, RMError>) in
            switch result {
            case.success(let locations):
                completion(.success(locations.results))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFilterLocations(filterParams: [RMFilterProtocol], completion: @escaping (Result<[RMLocation], Error>) -> Void) {
        let request = RMLocationRoute.filterLocation(filterProtocol: filterParams).urlRequestComplete
        dataManager.filterData(request: request) { (result: Result<ResponseHelper<RMLocation>, RMError>) in
            switch result {
            case.success(let locations):
                completion(.success(locations.results))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
