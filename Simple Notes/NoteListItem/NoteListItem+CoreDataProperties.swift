//
//  NoteListItem+CoreDataProperties.swift
//  Simple Notes
//
//  Created by Pablo Gatgens on 3/31/22.
//
//

import Foundation
import CoreData


extension NoteListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteListItem> {
        return NSFetchRequest<NoteListItem>(entityName: "NoteListItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var note: String?

}

extension NoteListItem : Identifiable {

}
