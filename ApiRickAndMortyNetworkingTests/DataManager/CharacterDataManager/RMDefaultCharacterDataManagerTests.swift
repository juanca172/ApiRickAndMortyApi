//
//  RMDefaultCharacterDataManagerTests.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import XCTest
@testable import ApiRickAndMortyNetworking

class RMDefaultCharacterDataManagerTests: XCTestCase {
    
    var dataManager: RMDefaultCharacterDataManager!
    var networkProviderMock: NetworkProviderMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkProviderMock = NetworkProviderMock()
        dataManager = RMDefaultCharacterDataManager(networkProvider: networkProviderMock)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RMDefaultCharacterDataManager_Get_Page_Success() {
        //Given
        let characterMock = RMCharacter(id: 1, name: "Rick", status: .Alive, species: "Dog", type: "Human", gender: .Male, image: "")
        let infoMock = Info(count: 2, pages: 3, next: "", prev: nil)
        let characterResponseHelperMock = ResponseHelper(info: infoMock, results: [characterMock])
        networkProviderMock.dataToReturn = characterResponseHelperMock
        let request = RMCharacterRoute.getPageCharacter(pageNumber: 2).urlRequestComplete
        let expectation = XCTestExpectation(description: "RMDefaultCharacterDataManager_Get_Page_Success")
        
        //When
        dataManager.getTypeByPage(pageNumber: 2, request: request, completion: { (result: Result<[RMCharacter], Error>) in
            switch result {
            case .success(let characters):
                //then
                XCTAssertEqual(characters.count, 1)
                XCTAssertEqual(characters.first!.id,characterMock.id)
                expectation.fulfill()
                
            case .failure(_):
                break
            }
            
        })
          wait(for: [expectation], timeout: 2.5)
    }
    
    func test_RMDefaultCharacterDataManager_Get_All_Character_Success() {
        //Given
        let characterMock = RMCharacter(id: 1, name: "Morty", status: .Alive, species: "Human", type: "Dog", gender: .Male, image: "")
        let infoMock = Info(count: 1, pages: 3, next: "", prev: nil)
        let characterResponseHelperMock = ResponseHelper(info: infoMock, results: [characterMock])
        networkProviderMock.dataToReturn = characterResponseHelperMock
        let expectation = XCTestExpectation(description: "test_RMDefaultCharacterDataManager_Get_All_Character_Success")
        //When
        dataManager.getAllCharacters { (result: Result<[RMCharacter], Error>) in
            switch result {
            case .success(let success):
                //then
                XCTAssertEqual(success.count, 1)
                XCTAssertEqual(success[0].name, characterMock.name)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
        
    }
    func test_RMDefaultCharacterDataManager_Get_Character_By_Id_Success() {
        //Given
        let characterMock = RMCharacter(id: 200, name: "Lawyer Morty", status: .unknown, species: "Human", type: "", gender: .Male, image: "")
        networkProviderMock.dataToReturn = characterMock
        let request = RMCharacterRoute.getOneCharacter(id: characterMock.id).urlRequestComplete
        let expectation = XCTestExpectation(description: "test_RMDefaultCharacterDataManager_Get_Character_By_Id_Success")
        //When
        dataManager.getOneCharacterById(id: 200, request: request) { (result: Result<RMCharacter, Error>) in
            switch result {
            case .success(let success):
                 //then
                XCTAssertEqual(success.id, characterMock.id)
                XCTAssertEqual(success.gender, characterMock.gender)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    
    func test_RMDefaultCharacterDataManager_Get_Multiple_Characters_Success () {
        //Given
        let characterMock1 = RMCharacter(id: 3, name: "Summer Smith", status: .Alive, species: "Human", type: "", gender: .Female, image: "")
        let characterResponseMock = [characterMock1]
        networkProviderMock.dataToReturn = characterResponseMock
        let expectation = XCTestExpectation(description: "test_RMDefaultCharacterDataManager_Get_Multiple_Characters_Success")
        dataManager.getAGroupOfCharacters(ids: [12]) { (result: Result<[RMCharacter], Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.first?.id, characterMock1.id)
                XCTAssertEqual(success.count, 1)
                XCTAssertEqual(success.first?.name, characterMock1.name)

                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    func test_RMDefaultCharacterDataManager_Get_Filter_Character_Succes () {
        let characterMock = RMCharacter(id: 2, name: "Morty Smith", status: .Alive, species: "Human", type: "", gender: .Male, image: "")
        let characterResponseMock = [characterMock]
        let filterCharacter = RMNameCharacter(name: "Morty Smith")
        networkProviderMock.dataToReturn = characterResponseMock
        let expectation = XCTestExpectation(description: "test_RMDefaultCharacterDataManager_Get_Filter_Character_Succes")
        dataManager.filterParams(filters: [filterCharacter]) { (result: Result<[RMCharacter], Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.first?.id, 2)
                XCTAssertEqual(success.first?.name, characterMock.name)
                
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    
    /*func test_get_characters_by_page() {
        let apiUrl = URL(string: "https://cuev.com")!
        let request = URLRequest(url: apiUrl)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let expectation = XCTestExpectation(description: "MockFailure")
        let arrayToEncode = ["Juan", "Camilo"]
        let data = try! JSONEncoder().encode(arrayToEncode)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: apiUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
             return (response, data)
        }
        let instance = NetworkProviderMock(urlSession: urlSession)
        var probe = RMDefaultCharacterDataManager(networkProvider: instance)
        probe.getCharactersByPage(pageNumber: 2) { (result:Result<[String], Error>) in
            switch result {
            case .success(let success):
                XCTAssertEqual(success[0], "Juan")
            case .failure(let failure):
                break
            }
        }
         
    }*/
   
}

class NetworkProviderMock: NetworkProviderProtocol {
    
    var dataToReturn: Decodable?
    
    func getData<T: Decodable>(urlRequest: URLRequest, _ datos: @escaping (Result<T, RMError>) -> Void) {
        
        if let dataToReturn = dataToReturn {
            datos(.success(dataToReturn as! T))
            return
        }
    }
}
