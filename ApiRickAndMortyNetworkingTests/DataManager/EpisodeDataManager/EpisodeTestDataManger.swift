//
//  EpisodeTestDataManger.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import XCTest
@testable import ApiRickAndMortyNetworking

final class EpisodeTestDataManger: XCTestCase {
    
    var networkProviderMock: NetworkProviderMockEpisodes!
    var dataManager: RMEpisodeDataManger!

    override func setUpWithError() throws {
        networkProviderMock = NetworkProviderMockEpisodes()
        dataManager = RMEpisodeDataManger(networKProvider: networkProviderMock)
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Get_A_Single_Episode_RMDefaultdatamanager() {
        
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        networkProviderMock.dataToRecive = result
        let request = RMEpisodesRoute.getASingleEpisode(episodeId: result.id).urlRequestComplete
        let expectation = expectation(description: "test_Get_A_Single_Episode_RMDefaultdatamanager")
        
        dataManager.getASingleEpisode(id: result.id) { (resultado: Result<RMEpisode, Error>) in
            switch resultado {
            case.success(let episode):
                XCTAssertEqual(episode.id, result.id)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    
    func test_Get_Multiple_Episode_RMDefaultdatamanager() {
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        networkProviderMock.dataToRecive = [result]
        
        let request = RMEpisodesRoute.getMultipleEpisodes(episodes: [result.id]).urlRequestComplete
        let expectation = expectation(description: "test_Get_Multiple_Episode_RMDefauldatamanager")
        
        dataManager.getMultipleEpisodes(ids: [result.id]) { (resultado: Result<[RMEpisode], Error>) in
            switch resultado {
            case.success(let episodes):
                XCTAssertEqual(episodes.first?.id, result.id)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)

    }
    
    func test_Get_Page_Episode_RMDefaultdatamanager() {
        
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        
        let info = ResponseHelper<RMEpisode>.Info(count: 51, pages: 1, next: "https://rickandmortyapi.com/api/episode?page=2", prev: nil)
        
        let response = ResponseHelper<RMEpisode>(info: info, results: [result])
        
        networkProviderMock.dataToRecive = response
        let request = RMEpisodesRoute.getEpisodePage(page: info.pages).urlRequestComplete
        let expectation = expectation(description: "test_Get_Page_Episode_RMDefaultdatamanager")
        
        dataManager.getPageEpisode(page: info.pages) { (resultado: Result<[RMEpisode], Error>) in
            switch resultado {
            case.success(let episodes):
                XCTAssertEqual(episodes.first?.id, result.id)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_Get_Filter_Episode_RMDefaultdamanager() {
        
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        
        let info = ResponseHelper<RMEpisode>.Info(count: 51, pages: 1, next: "https://rickandmortyapi.com/api/episode?page=2", prev: nil)
        
        let response = ResponseHelper(info: info, results: [result])
        
        networkProviderMock.dataToRecive = response
        let name = RMNameRouteEpisode(name: "Pilot")
        let request = RMEpisodesRoute.filterEpisodes(filteraBy: [name]).urlRequestComplete
        
        let expectation = expectation(description: "test_Get_Filter_Episode_RMDefaultdamanager")
        
        dataManager.getFilterEpisodes(filterParams: [name]) { (resultado: Result<[RMEpisode], Error>) in
            switch resultado {
            case.success(let episodes):
                XCTAssertEqual(episodes.first?.id, result.id)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}

class NetworkProviderMockEpisodes: NetworkProviderProtocol {
    
    var dataToRecive: Decodable? = nil
    
    func getData<T>(urlRequest: URLRequest, _ datos: @escaping (Result<T,RMError>) -> Void) where T : Decodable {
        
        if let dataToRecive = dataToRecive {
            datos(.success(dataToRecive as! T))
            return
        }
        
    }
    
    
}
