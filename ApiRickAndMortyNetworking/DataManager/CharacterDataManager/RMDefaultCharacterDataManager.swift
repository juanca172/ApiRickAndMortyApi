//
//  RMDefaultCharacterDataManager.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation



struct RMDefaultCharacterDataManager: RMDataManager {
    
    var networKProvider: NetworkProviderProtocol
    typealias T = RMCharacter
    
    init(networkProvider: NetworkProviderProtocol) {
        self.networKProvider = networkProvider
    }
    
}

extension RMDefaultCharacterDataManager: RMCharacterDataManagerProtocol {
    
    func getTypeByPage<T>(pageNumber: Int, request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getPage(request: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
            switch result {
            case.success(let page):
                if let fetchedPage = page.results as? [T] {
                    completion(.success(fetchedPage))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOneCharacterById<T>(id: Int, request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        self.getOne(request: request) { (result:Result<RMCharacter, RMError>) in
            switch result {
            case.success(let char):
                if let character =  char as? T {
                    completion(.success(character))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getAGroupOfCharacters<T>(ids: [Int], request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getMultiple(request: request) { (result: Result<[RMCharacter], RMError>) in
            switch result {
            case.success(let characters):
                if let fetchedChars = characters as? [T] {
                    completion(.success(fetchedChars))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterParams<T>(request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.filterData(request: request) { (result: Result<ResponseHelper<RMCharacter>, RMError>) in
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
    
    func getAllCharacters<T>(request: URLRequest, completion: @escaping (Result<[T], Error>) -> Void) where T : Decodable {
        self.getAll(request: request) { (result:Result<ResponseHelper<RMCharacter>, RMError>) in
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


