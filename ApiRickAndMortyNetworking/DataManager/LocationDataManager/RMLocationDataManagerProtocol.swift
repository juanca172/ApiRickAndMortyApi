//
//  RMLocationDataManagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

protocol RMLocationDataManagerProtocol {
    func getAllLocations<T: Decodable>(request: URLRequest,complition: @escaping (Result<[T], Error>) -> Void)
    func getASingleLocation<T: Decodable>(id: Int, request: URLRequest ,complition: @escaping (Result <T, Error>) -> Void)
    func getMultipleLocations<T: Decodable>(ids: [Int],request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void)
    func getPageLocation<T: Decodable> (page: Int, request: URLRequest ,complition: @escaping (Result<[T], Error>) -> Void)
    func getFilterLocations<T: Decodable> (request: URLRequest,complition: @escaping (Result <[T], Error>) -> Void)
}
