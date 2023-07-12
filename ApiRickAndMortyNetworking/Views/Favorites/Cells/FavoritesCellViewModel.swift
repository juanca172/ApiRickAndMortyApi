//
//  FavoritesCellViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/23.
//

import Foundation
import UIKit

struct FavoritesCellViewModel: RMTableViewCellModelProtocol {
    
    private let character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        character?.characterName ?? ""
    }
    var specie: String {
        character?.characterSpecie ?? ""
    }
    var type: String {
        character?.characterType ?? ""
    }
    
    var status: String {
        character?.characterStatus ?? ""
    }
    
    var loadImage: ((UIImage) -> ())? {
        didSet {
            getImage()
        }
    }
    
    private func getImage() {
        
        guard let url = URL(string: character?.characterImage ?? "") else {
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                return
            }
        
            self.loadImage?(image)
            
        }
    }
}

