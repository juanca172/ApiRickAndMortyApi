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

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_get_All_Episodes_RMDefaultDataManagerEpisode() {
        
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        
        let info = ResponseHelper<RMEpisode>.Info(count: 51, pages: 3, next: "https://rickandmortyapi.com/api/episode?page=2", prev: nil)
        
        let response = ResponseHelper(info: info, results: [result])
        
        networkProviderMock.dataToRecive = response
        let expectation = XCTestExpectation(description: "test_get_All_Episodes_RMDefaultDataManagerEpisode")
        let request = RMEpisodesRoute.getAllEpisodes.urlRequestComplete
        
        dataManager.getAllEpisodes(request: request) { (resultado: Result<[RMEpisode], Error>) in
            switch resultado {
            case.success(let episode):
                XCTAssertEqual(episode.first?.id, result.id)
                expectation.fulfill()
            case.failure(_):
                break
                
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    
    func test_Get_A_Single_Episode_RMDefaultdatamanager() {
        
        let result = RMEpisode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        networkProviderMock.dataToRecive = result
        let request = RMEpisodesRoute.getASingleEpisode(episodeId: result.id).urlRequestComplete
        let expectation = expectation(description: "test_Get_A_Single_Episode_RMDefaultdatamanager")
        
        
        dataManager.getASingleEpisode(id: result.id, request: request) { (resultado: Result<RMEpisode, Error>) in
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
        
        let request = RMEpisodesRoute.getMultipleEpisodes(episodes: [1]).urlRequestComplete
        let expectation = expectation(description: "test_Get_Multiple_Episode_RMDefauldatamanager")
        
        dataManager.getMultipleEpisodes(ids: [1], request: request) { (resultado: Result<[RMEpisode], Error>) in
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
        
        let response = ResponseHelper(info: info, results: [result])
        
        networkProviderMock.dataToRecive = response
        let request = RMEpisodesRoute.getEpisodePage(page: info.pages).urlRequestComplete
        let expectation = expectation(description: "test_Get_Page_Episode_RMDefaultdatamanager")
        
        dataManager.getPageEpisode(page: info.pages, request: request) { (resultado: Result<[RMEpisode], Error>) in
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
        
        dataManager.getFilterEpisodes(request: request) { (resultado: Result<[RMEpisode], Error>) in
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
