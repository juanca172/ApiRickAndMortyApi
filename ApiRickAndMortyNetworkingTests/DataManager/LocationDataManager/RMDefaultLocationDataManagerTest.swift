//
//  RMDefaultLocationDataManagerTest.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 4/05/23.
//

import XCTest
@testable import ApiRickAndMortyNetworking


final class RMDefaultLocationDataManagerTest: XCTestCase {
    
    var RMNetworProviderMock: NetworkProviderMockLocations!
    var dataManager: RMDefaultDataManagerLocation!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        RMNetworProviderMock = NetworkProviderMockLocations()
        dataManager = RMDefaultDataManagerLocation(networKProvider: RMNetworProviderMock)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func test_RMDefaultDatamanager_Get_Single_Location_Succes() {
        //Given
        let locationMock = RMLocation(id: 1, name: "Earth", type: "Planet", dimension: "Dimension C-137", residents:["https://rickandmortyapi.com/api/character/1","https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/location/1", created: "2017-11-10T12:42:04.162Z")
        RMNetworProviderMock.dataToReturn = locationMock
        let expectation = XCTestExpectation(description: "test_RMDefaultDatamanager_Get_Single_Location_Succes")
        let request = RMLocationRoute.getASingleLocation(id: locationMock.id).urlRequestComplete
        //When
        dataManager.getASingleLocation(id: locationMock.id) { (result: Result<RMLocation, Error>) in
            switch result {
            case.success(let location):
                //then
                XCTAssertEqual(location.id, locationMock.id)
                XCTAssertEqual(location.name, locationMock.name)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
    
    func test_RMDefaultDatamanager_Get_Multiple_Locations_Succes() {
        //Given
        let locationMock = RMLocation(id: 1, name: "Earth", type: "Planet", dimension: "Dimension C-137", residents:["https://rickandmortyapi.com/api/character/1","https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/location/1", created: "2017-11-10T12:42:04.162Z")
        RMNetworProviderMock.dataToReturn = [locationMock]
        let expectation = XCTestExpectation(description: "test_RMDefaultDatamanager_Get_Multiple_Locations_Succes")
        let request = RMLocationRoute.getMultipleLocations(ids: [locationMock.id]).urlRequestComplete
        //When
        
        dataManager.getMultipleLocations(ids: [locationMock.id]) { (result: Result<[RMLocation], Error>) in
            switch result {
            case.success(let locations):
                XCTAssertEqual(locations.first?.id, locationMock.id)
                XCTAssertEqual(locations.count, 1)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)

    }
    
    func test_RMDefaultDatamanager_Get_Filter_Location_Succes() {
        //Given
        let locationMock = RMLocation(id: 1, name: "Earth", type: "Planet", dimension: "Dimension C-137", residents:["https://rickandmortyapi.com/api/character/1","https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/location/1", created: "2017-11-10T12:42:04.162Z")
        let locationInfo = ResponseHelper<RMLocation>.Info(count: 126, pages: 7, next: "https://rickandmortyapi.com/api/location?page=2", prev: nil)
        let responseLocation = ResponseHelper(info: locationInfo, results: [locationMock])
        
        RMNetworProviderMock.dataToReturn = responseLocation
        
        let filterLocation = RMNameLocation(name: "Earth2")
        let request = RMLocationRoute.filterLocation(filterProtocol: [filterLocation]).urlRequestComplete
        let expectation = expectation(description: "test_RMDefaultDatamanager_Get_Filter_Location_Succes")
        //When
        dataManager.getFilterLocations(filterParams: [filterLocation]) { (result: Result<[RMLocation], Error>) in
            switch result {
            case.success(let locations):
                XCTAssertEqual(locations.first?.name, locationMock.name)
                XCTAssertEqual(locations.first?.id, locationMock.id)
                expectation.fulfill()
            case.failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 2.5)
    }
}

    
class NetworkProviderMockLocations: NetworkProviderProtocol {
    
    var dataToReturn: Decodable?
    
    func getData<T>(urlRequest: URLRequest, _ datos: @escaping (Result<T, RMError>) -> Void) where T : Decodable {
        
        if let data = dataToReturn {
            datos(.success(data as! T))
            return
        }
        
    }
}
    
