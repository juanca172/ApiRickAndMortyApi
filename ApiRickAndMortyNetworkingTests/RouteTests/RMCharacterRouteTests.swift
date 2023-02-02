//
//  ApiRickAndMortyNetworkingTests.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 1/07/22.
//

import XCTest
@testable import ApiRickAndMortyNetworking
class ApiRickAndMortyNetworkingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetOneCharacterRequest1() {
        //Given
        let expectedValue = 2
        let expectedURLString = "https://rickandmortyapi.com/api/character/\(expectedValue)"
        let request = RMCharacterRoute.getOneCharacter(id: expectedValue)
        //When
        let urlRequest = request.URLRequestComplete
        //Then
        XCTAssertEqual(expectedURLString, urlRequest.url?.absoluteString)
    }
    func testGetAllCharacterRequest1() {
        //Given
        let expectedValue = "character"
        let expectedURLString = "https://rickandmortyapi.com/api/\(expectedValue)"
        let request = RMCharacterRoute.getAllCharacter
        //When
        let urlRequest = request.URLRequestComplete
        //Then
        XCTAssertEqual(expectedURLString, urlRequest.url?.absoluteString)
    }
    func testGetPageCharacter() {
        //Given
        let expectedValue = 1
        let expectedURLString = "https://rickandmortyapi.com/api/character/?page=\(expectedValue)"
        let request = RMCharacterRoute.getPageCharacter(pageNumber: expectedValue)
        //When
        let urlRequest = request.URLRequestComplete
        //Then
        XCTAssertEqual(expectedURLString, urlRequest.url?.absoluteString)
    }
    func testGetMultipleCharacter() {
        //Given
        let expectedValue = [1,183]
        let expectedURLString = "https://rickandmortyapi.com/api/character/1,183"
        let request = RMCharacterRoute.getMultipleCharacters(ids: expectedValue)
        //when
        let urlRequest = request.URLRequestComplete
        //then
        XCTAssertEqual(expectedURLString, urlRequest.url?.absoluteString)
    }
    func testGetFilterCharacter(){
        //Given
        let expectedValue = "rick%20sanchez"
        let status = "alive"
        let genre = "male"
        let expectedURLString = "https://rickandmortyapi.com/api/character/?name=\(expectedValue)&status=\(status)&genre=\(genre)"
        let statusRM = RMStatusCharacter(status: RMCharacterStatus.Alive.rawValue)
        let name = RMNameCharacter(name: "Rick Sanchez")
        let genreRM = RMGeneroCharacter(genre: RMCharacterGender.Male.rawValue)
        let request = RMCharacterRoute.filterCharacter(filterProtocol: [name, statusRM,genreRM])
        //when
        let urlRequest = request.URLRequestComplete
        //then
        XCTAssertEqual(expectedURLString, urlRequest.url?.absoluteString)
    }
   
}
