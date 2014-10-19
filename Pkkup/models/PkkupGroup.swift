//
//  PkkupGroup.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

class PkkupGroup {
    var groupDictionary: NSDictionary?
    
    var id: Int?
    var name: String?
    var isSelected: Bool?
    init(dictionary: NSDictionary) {
        self.groupDictionary = dictionary
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        isSelected = false
    }

    class func groupsWithArray(array: [NSDictionary]) -> [PkkupGroup] {
        var groups = [PkkupGroup]()
        for dictionary in array {
            groups.append(PkkupGroup(dictionary: dictionary))
        }
        return groups
    }
}
