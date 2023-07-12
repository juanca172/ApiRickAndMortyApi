//
//  DetailViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/07/23.
//

import Foundation

protocol DetailViewModelProtocol {
    func saveContext()
    func getCharacterForDetail(id: Int)
    var characterById: (( _ characterUI: RMCharacter) -> ())? {get set}

}

class DetailViewModel: DetailViewModelProtocol {
    
    private var coreDataManager: CoreDataManagerProtocol
    private var dataManager: RMCharacterDatamanager
    private var characterObtained: RMCharacter?
    var characterById: ((RMCharacter) -> ())?

    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager(coreData: CoreDataStack()), dataManager: RMCharacterDatamanager = RMDefaultCharacterDataManager(networkProvider: NetworkProvider())) {
        self.coreDataManager = coreDataManager
        self.dataManager = dataManager
    }
    

    func getOneCharacter(for given: Int) {
        
        let identifier = given > 0 ? given : 1

        dataManager.getOneCharacterById(id: identifier) { [weak self] (result: Result<RMCharacter, Error>) in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case.success(let character):
                weakSelf.characterObtained = character
                weakSelf.characterById?(character)
                print(character.name)
            case.failure(let error):
                print(error)
            
            }
        }
    }

    
}

//MARK: Conformacion de protocolo
extension DetailViewModel {
    
    func saveContext() {
        guard let character = characterObtained else {
            return
        }
        coreDataManager.saveData(obtained: character)
    }
    
    func getCharacterForDetail(id: Int) {
        getOneCharacter(for: id)
        print("Character")
    }

    
}
