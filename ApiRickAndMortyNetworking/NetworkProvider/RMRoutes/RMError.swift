//
//  RMErrorAndDecodableStructures.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 23/07/22.
//

import Foundation

enum RMError: Error  {
    case datosNotFound
    case networkError(Error)
    case imposibleDecodiar
}
extension RMError : Equatable {
    static func == (lhs: RMError, rhs: RMError) -> Bool {
        switch (lhs, rhs) {
        case (datosNotFound,datosNotFound):
            return true
        case(imposibleDecodiar, imposibleDecodiar):
            return true
        case (networkError(let error1), networkError(let error2)):
            return "\(error1)" == "\(error2)"
        default:
            return false
        }
    }
}
