//
//  RouteProtocols.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 18/06/23.
//

import Foundation

protocol RMFilterProtocol {
    var filterTuple: (String, String) {get}
}

protocol URLComplete {
    var finalURL: String {get}
    var urlRequestComplete: URLRequest {get}
}
