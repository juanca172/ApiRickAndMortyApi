//
//  RMEpisodeDatamangerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation

protocol RMEpisodeDatamangerProtocol {
    func getAllEpisodes<T: Decodable>(request: URLRequest,complition: @escaping (Result<[T], Error>) -> Void)
    func getASingleEpisode<T: Decodable>(id: Int, request: URLRequest ,complition: @escaping (Result <T, Error>) -> Void)
    func getMultipleEpisodes<T: Decodable>(ids: [Int],request: URLRequest, complition: @escaping (Result<[T], Error>) -> Void)
    func getPageEpisode<T: Decodable> (page: Int, request: URLRequest ,complition: @escaping (Result<[T], Error>) -> Void)
    func getFilterEpisodes<T: Decodable> (request: URLRequest,complition: @escaping (Result <[T], Error>) -> Void)
}
