//
//  RMDefaultCharacterDataManager.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation



struct RMDefaultCharacterDataManager {
    
    var networKProvider: NetworkProviderProtocol
    var dataManager: RMDataManager<RMCharacter>
    
    init(networkProvider: NetworkProviderProtocol) {
        self.networKProvider = networkProvider
        self.dataManager = RMDataManager(networKProvider: networkProvider)
    }
    
}

extension RMDefaultCharacterDataManager: RMCharacterDatamanager {
    
    func getCharacterByPage(pageNumber: Int, completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getPageCharacter(pageNumber: pageNumber).urlRequestComplete
        dataManager.getPage(request: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
            switch result {
            case.success(let page):
                completion(.success(page.results))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOneCharacterById(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        let request = RMCharacterRoute.getOneCharacter(id: id).urlRequestComplete
        dataManager.getOne(request: request) { (result:Result<RMCharacter, RMError>) in
            switch result {
            case.success(let char):
                completion(.success(char))
            case.failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getAGroupOfCharacters(ids: [Int], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getMultipleCharacters(ids: ids).urlRequestComplete
        dataManager.getMultiple(request: request) { (result: Result<[RMCharacter], RMError>) in
            switch result {
            case.success(let characters):
                completion(.success(characters))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterParams(filter: [RMFilterProtocol], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.filterCharacter(filterProtocol: filter).urlRequestComplete
        dataManager.filterData(request: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
