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
    
    
}/*
struct RMDefaultCharacterDataManager: RMCharacterDataManagerProtocol {
    
    let networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    
    func getTypeByPage<T>(pageNumber: Int,request: URLRequest , completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper<T>, RMError>) in
            switch result {
            case .success(let response):
                if let result = response.results as? [T] {
                    completion(.success(result))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOneCharacterById<T>(id: Int, request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
                
        networkProvider.getData(urlRequest: request) { (result: Result<RMCharacter, RMError>) in
            switch result {
                
            case .success(let character):
                if let character = character as? T {
                    completion(.success(character))
                }
            case .failure(let error) :
                completion(.failure(error))
                
            }
        }
    }
    
    
    func getAGroupOfCharacters<T>(ids: [Int], request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        //let request = RMCharacterRoute.getMultipleCharacters(ids: ids).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<[RMCharacter], RMError>) in
            switch result {
            case .success(let characters):
                if let fetchedCharacters = characters as? [T] {
                    completion(.success(fetchedCharacters))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterParams<T>(request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
            switch result {
            case .success(let characters):
                if let fetchedCharacters = characters.results as? [T] {
                    completion(.success(fetchedCharacters))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    func getAllCharacters<T>(request: URLRequest,completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        //let request = RMCharacterRoute.getAllCharacter.urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
            switch result {
            case .success(let characters):
                if let fetchedCharacters = characters.results as? [T] {
                    completion(.success(fetchedCharacters))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}*/


