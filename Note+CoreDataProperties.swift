//
//  Note+CoreDataProperties.swift
//  Brain Exoneration
//
//  Created by Kamil Niemczyk on 16/02/2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String

}

extension Note : Identifiable {

}
