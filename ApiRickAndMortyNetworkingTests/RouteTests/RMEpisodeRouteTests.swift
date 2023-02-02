//
//  TestEpisodeRickAndMorty.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 20/07/22.
//

import XCTest
@testable import ApiRickAndMortyNetworking
class TestEpisodeRickAndMorty: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllEpisodes () {
        //Given
        let expectedValue = "episode"
        let RMEpisode = RMEpisodesRoute.getAllEpisodes.urlRequestComplete
        //When
        let expectedURL = "https://rickandmortyapi.com/api/\(expectedValue)"
        //Then
        XCTAssertEqual(expectedURL, RMEpisode.url?.absoluteString)
    }
    func testGetASingleEpisode () {
        //Given
        let expectedValue = 2
        let RMEpisode = RMEpisodesRoute.getASingleEpisode(episodeId: expectedValue).urlRequestComplete
        //When
        let expectedURL = "https://rickandmortyapi.com/api/episode/\(expectedValue)"
        //then
        XCTAssertEqual(expectedURL, RMEpisode.url?.absoluteString)
    }
    func testGetFilterEpisode () {
        //Given
        let nameEpisode = RMNameRouteEpisode(name: "The Ricklantis Mixup")
        let episode = RMEpisodeFilter(episode: "S03E07".lowercased())
        let filtar = RMEpisodesRoute.filterEpisodes(filteraBy: [nameEpisode, episode]).urlRequestComplete
        //When
        let expectedURL = "https://rickandmortyapi.com/api/episode/?name=the%20ricklantis%20mixup&episode=s03e07"
        //Then
        XCTAssertEqual(expectedURL, filtar.url?.absoluteString)
        
    }

}
