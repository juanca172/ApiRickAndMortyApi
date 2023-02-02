//
//  RMCharacter.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/08/22.
//

import Foundation

enum RMCharacterStatus: String, Decodable {
    case Alive
    case Dead
    case unknown
}


enum RMCharacterGender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
}
 

struct RMCharacter: Decodable {
    
    var id : Int
    var name: String
    var status: RMCharacterStatus
    var species: String
    var type: String
    var gender : RMCharacterGender
    var image: String
    
}
