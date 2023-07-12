//
//  Character+CoreDataProperties.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/23.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var characterId: Int16
    @NSManaged public var characterImage: String?
    @NSManaged public var characterName: String?
    @NSManaged public var characterSpecie: String?
    @NSManaged public var characterStatus: String?
    @NSManaged public var characterType: String?

}

extension Character : Identifiable {

}
