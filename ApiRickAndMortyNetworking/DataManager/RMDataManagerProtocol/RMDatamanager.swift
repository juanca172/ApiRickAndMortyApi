//
//  RMDatamanagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 23/06/23.
//

import Foundation


//cambiar a struct
//completion cambiar
struct RMDataManager <T: Decodable> {
    //RMCharacter
    var networKProvider: NetworkProviderProtocol
    
    init(networKProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networKProvider = networKProvider
    }
    
}

extension RMDataManager {
    
    
    func getPage(request: URLRequest, completion: @escaping((Result<ResponseHelper<T>, RMError>) -> Void)) {
        networKProvider.getData(urlRequest: request, completion)
    }
    
    func getOne(request: URLRequest, completion: @escaping(Result<T, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, completion)
    }
    
    func getMultiple(request: URLRequest, completion: @escaping(Result<[T], RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, completion)
    }
    
    func filterData(request: URLRequest, completion: @escaping(Result<ResponseHelper<T>, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, completion)
    }
    
    func getAll(request: URLRequest, completion: @escaping (Result<ResponseHelper<T>, RMError>) -> Void) {
        networKProvider.getData(urlRequest: request, completion)
    }
    
    
}
