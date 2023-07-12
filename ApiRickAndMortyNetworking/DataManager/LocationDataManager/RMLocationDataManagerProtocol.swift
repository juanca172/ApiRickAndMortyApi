//
//  RMLocationDataManagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 2/06/23.
//

import Foundation

protocol RMLocationDataManagerProtocol {
    func getASingleLocation(id: Int,completion: @escaping (Result <RMLocation, Error>) -> Void)
    func getMultipleLocations(ids: [Int], completion: @escaping (Result<[RMLocation], Error>) -> Void)
    func getPageLocation (page: Int ,completion: @escaping (Result<[RMLocation], Error>) -> Void)
    func getFilterLocations(filterParams: [RMFilterProtocol],completion: @escaping (Result <[RMLocation], Error>) -> Void)
}
