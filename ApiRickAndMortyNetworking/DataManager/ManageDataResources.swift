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
