//
//  RMDefaultCharacterDataManager.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation

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
    
    func getAGroupOfCharacters(ids: [Int], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getMultipleCharacters(ids: ids).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<[RMCharacter], RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterParams(filters: [RMFilterProtocol], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.filterCharacter(filterProtocol: filters).urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper, RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getAllCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getAllCharacter.urlRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<ResponseHelper, RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


