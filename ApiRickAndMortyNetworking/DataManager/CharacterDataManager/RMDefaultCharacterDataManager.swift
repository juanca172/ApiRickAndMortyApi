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
    
    func getCharactersByPage(pageNumber: Int, completion: @escaping (Result<[RMCharacter],Error>) -> Void) {
        let request = RMCharacterRoute.getPageCharacter(pageNumber: pageNumber).URLRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<CharacterResponseHelper, RMError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOneCharacterById(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        let identifier = id > 0 ? id : 1
        let request = RMCharacterRoute.getOneCharacter(id: identifier).URLRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<RMCharacter, RMError>) in
            switch result {
            case .success(let character):
                completion(.success(character))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    func getAGroupOfCharacters(ids: [Int], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getMultipleCharacters(ids: ids).URLRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<[RMCharacter], RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterParams(filters: [RMCharacterFilterProtocol], completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.filterCharacter(filterProtocol: filters).URLRequestComplete
        print(request.url?.absoluteString)
        networkProvider.getData(urlRequest: request) { (result: Result<CharacterResponseHelper, RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getAllCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getAllCharacter.URLRequestComplete
        networkProvider.getData(urlRequest: request) { (result: Result<CharacterResponseHelper, RMError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


