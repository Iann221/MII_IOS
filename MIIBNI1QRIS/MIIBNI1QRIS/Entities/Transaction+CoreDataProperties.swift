//
//  Transaction+CoreDataProperties.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var sumber: String?
    @NSManaged public var id: String?
    @NSManaged public var merchant: String?
    @NSManaged public var nominal: Int64
    @NSManaged public var date: Date?

}

extension Transaction : Identifiable {

}
