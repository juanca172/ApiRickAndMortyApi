//
//  RMDatamanagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 23/06/23.
//

import Foundation

protocol RMDataManager {
    //RMCharacter
    associatedtype T: Decodable
    var networKProvider: NetworkProviderProtocol {get}
}

extension RMDataManager {
    
    
    func getPage(request: URLRequest, complition: @escaping((Result<ResponseHelper<T>, RMError>) -> Void)) {
        networKProvider.getData(urlRequest: request, complition)
    }
    
    func getOne(request: URLRequest, complition: @escaping(Result<T, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, complition)
    }
    
    func getMultiple(request: URLRequest, complition: @escaping(Result<[T], RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, complition)
    }
    
    func filterData(request: URLRequest, complition: @escaping(Result<ResponseHelper<T>, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, complition)
    }
    
    func getAll(request: URLRequest, complition: @escaping (Result<ResponseHelper<T>, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, complition)
    }
    
}
