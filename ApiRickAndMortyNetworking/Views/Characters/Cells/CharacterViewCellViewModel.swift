//
//  CharacterViewCellViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 19/04/23.
//

import Foundation
import UIKit

struct CharacterViewCellViewModel: RMTableViewCellModelProtocol {
    
    private let character: RMCharacter?
    
    init(character: RMCharacter?) {
        self.character = character
    }
    
    var name: String {
        character?.name ?? ""
    }
    var specie: String {
        character?.species ?? ""
    }
    var type: String {
        character?.type ?? ""
    }
    
    var loadImage: ((UIImage) -> ())? {
        didSet {
            getImage()
        }
    }
    
    private func getImage() {
        
        guard let url = URL(string: character?.image ?? "") else {
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
