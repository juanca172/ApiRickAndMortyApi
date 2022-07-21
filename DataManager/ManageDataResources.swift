//
//  ManageDataResources.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/22.
//

import Foundation

enum RMCharacterErrorRequest: Error {
    case DontExistThatPage
    case DoesNotExistAnyCharacterWithThatId
}
protocol MockingRMData {
    func getData<T: Decodable>(urlRequest: URLRequest,_ completion: @escaping (Result<T, RMError>) -> Void)
}
protocol RMCharacterManagerDataProtocol {
    //Function that brigs the page of characters
    //parametro de entrada pageNumber el cual nos sirve para saber en que pagina esta
    func getCharactersByPage(pageNumber: Int,_ complition: @escaping (Result<ApiResponseCharacter,Error>) -> Void)
    
    //Function that brings a single character
    //parameter id para traer el pesonaje con esa id
    func getOneCharacterById(id: Int, _ complition: @escaping (Result<DatosCharacter, Error>) -> Void)
    
    //Function that brings a group of characters
    //parameter ids para traer el conjunto de pesonajes
    func getAGroupOfCharacters(ids: [Int], _ conplition: @escaping (Result<[DatosCharacter],Error>) -> Void)
    
    //function that filter Characters
    func filterParams(Filters: [RMFilterCharacterProtocol], _ complition: @escaping (Result<ApiResponseCharacter, Error>) -> Void)
}
struct RMDefaulManagerCharacter: RMCharacterManagerDataProtocol {
    func getCharactersByPage(pageNumber: Int, _ complition: @escaping (Result<ApiResponseCharacter, Error>) -> Void) {
        guard pageNumber > 0 else {
            RMCharacterErrorRequest.DontExistThatPage
            return
        }
        let request = RMCharacterRoute.getPageCharacter(pageNumber: pageNumber).URLRequestComplete
        
    }
    
    func getOneCharacterById(id: Int, _ complition: @escaping (Result<DatosCharacter, Error>) -> Void) {
        guard id > 0 else {
            RMCharacterErrorRequest.DoesNotExistAnyCharacterWithThatId
            return
        }
        let request = RMCharacterRoute.getOneCharacter(id: id).URLRequestComplete
    }
    
    func getAGroupOfCharacters(ids: [Int], _ conplition: @escaping (Result<[DatosCharacter], Error>) -> Void) {
        let request = RMCharacterRoute.getMultipleCharacters(ids: ids).URLRequestComplete
    }
    
    func filterParams(Filters: [RMFilterCharacterProtocol], _ complition: @escaping (Result<ApiResponseCharacter, Error>) -> Void) {
        
    }
}


