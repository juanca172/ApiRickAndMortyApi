//
//  TestLocationApiRickAndMorty.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 16/07/22.
//

import XCTest
@testable import ApiRickAndMortyNetworking

class TestLocationApiRickAndMorty: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllLocations () {
        //Given
        let expectedValue = "/location"
        let expectedURLComplete = "https://rickandmortyapi.com/api\(expectedValue)"
        //When
        let request = RMLocationRoute.getAllLocations.urlRequestComplete
        //Then
        XCTAssertEqual(expectedURLComplete, request.url?.absoluteString)
    }
    func testGetASingleLocation () {
        //Given
        let expectedValue = 1
        let expectedURLComplete = "https://rickandmortyapi.com/api/location/\(expectedValue)"
        //When
        let request = RMLocationRoute.getASingleLocation(id: expectedValue).urlRequestComplete
        //Then
        XCTAssertEqual(expectedURLComplete, request.url?.absoluteString)
    }
    func testGetMultipleLocations () {
        //Given
        let expectedValue = [3,21]
        let expectedURLComplete = "https://rickandmortyapi.com/api/location/3,21"
        //When
        let request = RMLocationRoute.getMultipleLocations(ids: expectedValue).urlRequestComplete
        //Then
        XCTAssertEqual(expectedURLComplete, request.url?.absoluteString)
    }
    func testGetFilterLocation () {
        let name = RMNameLocation(name: "Earth")
        //Given
        let expectedValue = "/?name=earth"
        let expectedURLComplete = "https://rickandmortyapi.com/api/location\(expectedValue)"
        //When
        let request = RMLocationRoute.filterLocation(filterProtocol: [name]).urlRequestComplete
        //Then
        XCTAssertEqual(expectedURLComplete, request.url?.absoluteString)
    }
    func testGetFilterLocation2 () {
        let dimension = RMDimensionLocation(dimension: "Unknown")
        //Given
        let expectedValue = "/?dimension=unknown"
        let expectedURLComplete = "https://rickandmortyapi.com/api/location\(expectedValue)"
        //When
        let request = RMLocationRoute.filterLocation(filterProtocol: [dimension]).urlRequestComplete
        //Then
        XCTAssertEqual(expectedURLComplete, request.url?.absoluteString)
    }
    func testGetPageIndicated () {
        //Given
        let expectedValue = "?page=1"
        let expectedUrlComplete = "https://rickandmortyapi.com/api/location/\(expectedValue)"
        //When
        let request = RMLocationRoute.getPageIndicated(page: 1).urlRequestComplete
        //Then
        XCTAssertEqual(expectedUrlComplete, request.url?.absoluteString)
    }
    
}
