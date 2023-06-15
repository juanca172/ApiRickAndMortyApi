//
//  LocationCellViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 5/06/23.
//

import Foundation

struct LocationCellViewModel: RMTableViewCellModelProtocol {
    private var location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    var name: String {
        return location.name
    }
    
    var type: String {
        return location.type
    }
    
    var dimension: String {
        return location.dimension
    }
    
    
}
