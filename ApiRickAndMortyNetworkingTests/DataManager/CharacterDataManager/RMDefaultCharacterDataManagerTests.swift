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
        let infoMock = ResponseHelper<RMCharacter>.Info(count: 2, pages: 3, next: "", prev: nil)
        let characterResponseHelperMock = ResponseHelper(info: infoMock, results: [characterMock])
        networkProviderMock.dataToReturn = characterResponseHelperMock
        let expectation = XCTestExpectation(description: "RMDefaultCharacterDataManager_Get_Page_Success")
        
        //When
        dataManager.getCharacterByPage(pageNumber: infoMock.pages) { (result: Result<[RMCharacter], Error>) in
            switch result {
            case .success(let characters):
                //then
                XCTAssertEqual(characters.count, 1)
                XCTAssertEqual(characters.first!.id,characterMock.id)
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
        dataManager.getOneCharacterById(id: characterMock.id) { (result: Result<RMCharacter, Error>) in
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
        let request = RMCharacterRoute.getMultipleCharacters(ids: [3]).urlRequestComplete
        
        //When
        dataManager.getAGroupOfCharacters(ids: [3]) { (result: Result<[RMCharacter], Error>) in
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
        let infoMock = ResponseHelper<RMCharacter>.Info(count: 2, pages: 3, next: "", prev: nil)
        let characterResponseHelperMock = ResponseHelper(info: infoMock, results: [characterMock])
        let filterCharacter = RMNameCharacter(name: "Morty Smith")
        networkProviderMock.dataToReturn = characterResponseHelperMock
        let expectation = XCTestExpectation(description: "test_RMDefaultCharacterDataManager_Get_Filter_Character_Succes")
        dataManager.filterParams(filter: [filterCharacter]) { (result: Result<[RMCharacter], Error>) in
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
