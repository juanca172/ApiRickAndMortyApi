//
//  coreDataManager.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/07/23.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    
    func saveData(obtained: RMCharacter)
    func fetchData(complition: (([Character]) -> ()))
    
}
class CoreDataManager: CoreDataManagerProtocol {
    
    private let coreData: CoreDataStackProtocol?
    
    init(coreData: CoreDataStackProtocol) {
        self.coreData = coreData
    }
    
    func saveData(obtained: RMCharacter) {
        guard let manage = coreData?.managedContext else {
            return
        }
        let characterManage = Character(context: manage)
        characterManage.characterName = obtained.name
        characterManage.characterSpecie = obtained.species
        characterManage.characterStatus = obtained.status.rawValue
        characterManage.characterType = obtained.type
        characterManage.characterImage = obtained.image
        characterManage.characterId = Int16(obtained.id)

        coreData?.save()
        print("Works!")
    }
    
    func fetchData(complition: (([Character]) -> ())) {
        
        guard let manage = coreData?.managedContext else {
            return
        }
        let fetchRequest = NSFetchRequest<Character>()
        
        let entity = Character.entity()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "characterName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let locations = try manage.fetch(fetchRequest)
            complition(locations)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
