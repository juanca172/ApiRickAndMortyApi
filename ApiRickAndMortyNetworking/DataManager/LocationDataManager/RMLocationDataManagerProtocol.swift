//
//  RMLocationDataManagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

protocol RMLocationDataManagerProtocol {
    func getAllLocations (complition: @escaping (Result<[RMLocation], Error>) -> Void)
    func getASingleLocation(id: Int, complition: @escaping (Result <RMLocation, Error>) -> Void)
    func getMultipleLocations (ids: [Int], complition: @escaping (Result<[RMLocation], Error>) -> Void)
    func getPageLocation (page: Int, complition: @escaping (Result<[RMLocation], Error>) -> Void)
    func getFilterLocations (filters: [RMFilterLocationProtocol], complition: @escaping (Result <[RMLocation], Error>) -> Void)
}
