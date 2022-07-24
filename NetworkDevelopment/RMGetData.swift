//
//  RMGetData.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import Foundation

protocol RMGetDataProtocol {
    func getData<T: Decodable>(urlRequest: URLRequest,_ datos: @escaping (Result<T, RMError>) -> Void)
}
struct ApiRickAndMortyGeneric: RMGetDataProtocol {
    var urlSession: URLSession
    var jsonDecoder: JSONDecoder
    init (urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    func getData<T: Decodable>(urlRequest: URLRequest,_ completion: @escaping (Result<T, RMError>) -> Void) {
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(RMError.datosNotFound))
                return
            }
            if let error = error {
                let resultError = RMError.networkError(error)
                completion(.failure(resultError))
                return
            }
            do {
                let valor = try jsonDecoder.decode(T.self, from: data)
                completion(.success(valor))
            } catch {
                completion(.failure(.imposibleDecodiar))
            }
        
        }.resume()
    }
}
    

