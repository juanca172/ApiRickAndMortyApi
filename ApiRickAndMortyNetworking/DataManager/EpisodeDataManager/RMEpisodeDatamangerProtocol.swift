//
//  RMEpisodeDatamangerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation

protocol RMEpisodeDatamangerProtocol {
    func getASingleEpisode(id: Int,completion: @escaping (Result <RMEpisode, Error>) -> Void)
    func getMultipleEpisodes(ids: [Int], completion: @escaping (Result<[RMEpisode], Error>) -> Void)
    func getPageEpisode(page: Int,completion: @escaping (Result<[RMEpisode], Error>) -> Void)
    func getFilterEpisodes(filterParams: [RMFilterProtocol],completion: @escaping (Result <[RMEpisode], Error>) -> Void)
}
