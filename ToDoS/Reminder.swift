//
//  Reminder.swift
//  ToDoS
//
//  Created by Ciobanasu Ion on 21/05/2018.
//  Copyright © 2018 Ciobanasu Ion. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    // Properties
    var notification: UILocalNotification
    var name: String
    var time: NSDate
    
    // Archive Paths for Persistent Data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = 
    
    // enum for property types
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
}
