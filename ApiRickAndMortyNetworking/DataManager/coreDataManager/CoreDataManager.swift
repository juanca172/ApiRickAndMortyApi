//
//  coreDataManager.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 6/07/23.
//

import Foundation

protocol CoreDataManagerProtocol {
    func saveData(obtained: RMCharacter)
}
class CoreDataManager: CoreDataManagerProtocol {
    func saveData(obtained: RMCharacter) {
        let characterManage = Character(context: AppDelegate.sharedAppDelegate.coreDataStack.managedContex)
        characterManage.characterName = obtained.name
        characterManage.characterSpecie = obtained.species
        characterManage.characterStatus = obtained.status.rawValue
        characterManage.characterType = obtained.type
        characterManage.characterImage = obtained.image
        do {
            try AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            print("Works!")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
