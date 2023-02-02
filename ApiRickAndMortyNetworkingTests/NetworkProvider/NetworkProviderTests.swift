//
//  MockNetworkingRM.swift
//  ApiRickAndMortyNetworkingTests
//
//  Created by Juan Camilo Fonseca Gomez on 13/07/22.
//

import XCTest
@testable import ApiRickAndMortyNetworking

class NetworkProviderTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_NetworkProvider_Success() {
        //Given
        let apiURL = URL(string: "https://rickandmortyapi.com/api/character")!
        let request = URLRequest(url: apiURL)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let expectation = XCTestExpectation(description: "Descripcion")
        MockURLProtocol.requestHandler = { request in
            let arrayToEncode = ["juan","camilo","fonseca"]
            let data = try! JSONEncoder().encode(arrayToEncode)
            let response = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return  (response,data)
        }
        let networkProvider = NetworkProvider(urlSession: urlSession)
        //When
        networkProvider.getData(urlRequest: request) { (result: Result<[String], RMError>) in
            switch result {
            case .success(let success):
                //then
                XCTAssertEqual(success[0], "juan")
                XCTAssertEqual(success[1], "camilo")
                XCTAssertEqual(success[2], "fonseca")
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_NetworkProvider_Failure() {
        //Given
        let apiUrl = URL(string: "https://cuev.com")!
        let request = URLRequest(url: apiUrl)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let expectation = XCTestExpectation(description: "MockFailure")
        let data = Data()
        MockURLProtocol.requestHandler = {request in
            let response = HTTPURLResponse(url: apiUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let networkProvider = NetworkProvider(urlSession: urlSession)
        //When
        networkProvider.getData(urlRequest: request) { (result: Result<String, RMError>) in
            switch result {
            case .success(_):
                break
            case .failure(let error) :
                
                XCTAssertEqual(error, RMError.imposibleDecodiar)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_NetworkProvider_Failure_Throwing_Error() {
        //Given
        let apiUrl = URL(string: "https://cuev.com")!
        let request = URLRequest(url: apiUrl)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let expectation = XCTestExpectation(description: "MockFailure")
        let expectedError = MockError.mockError
        MockURLProtocol.requestHandler = { request in
            throw expectedError
        }
        let networkProvider = NetworkProvider(urlSession: urlSession)
        //When
        networkProvider.getData(urlRequest: request) { (result: Result<String, RMError>) in
            switch result {
            case .success(_):
                break
            case .failure(_) :
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        // To check if this protocol can handle the given request.
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Here you return the canonical version of the request but most of the time you pass the orignal one.
        return request
    }
    
    override func startLoading() {
        
        // This is where you create the mock response as per your test case and send it to the URLProtocolClient.
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("handler is unavailable")
        }
        
        do {
            let (response, data) = try handler(self.request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // This is called if the request gets canceled or completed.
    }
    
}

fileprivate enum MockError: Error {
    case mockError
}
