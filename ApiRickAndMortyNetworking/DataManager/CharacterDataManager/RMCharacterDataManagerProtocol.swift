//
//  RMCharacterDataManagerProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation

protocol RMCharacterDataManagerProtocol {
    //Function that brigs the page of characters
    //parametro de entrada pageNumber el cual nos sirve para saber en que pagina esta
    func getCharactersByPage(pageNumber: Int, completion: @escaping (Result<[RMCharacter],Error>) -> Void)
    
    //Function that brings a single character
    //parameter id para traer el pesonaje con esa id
    func getOneCharacterById(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void)
    
    //Function that brings a group of characters
    //parameter ids para traer el conjunto de pesonajes
    func getAGroupOfCharacters(ids: [Int], completion: @escaping (Result<[RMCharacter],Error>) -> Void)
    
    //function that Character filter
    //Parameter that filter characters
    func filterParams(filters: [RMCharacterFilterProtocol], completion: @escaping (Result<[RMCharacter], Error>) -> Void)
    
    //funtion that bring all characters
    func getAllCharacters(completion: @escaping (Result <[RMCharacter], Error>) -> Void)
    
}

