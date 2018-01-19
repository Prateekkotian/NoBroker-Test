//
//  PropertyModel.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/18/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import Foundation

class PropertyModel {
    var furnishingDesc: String = ""
    var rent: Int = 0
    var photos = [String: AnyObject]()
    var propertySize: Int = 0
    var bathroom: Int = 0
    var propertyTitle: String = ""
    var locality: String = ""
    var displayPic: String = ""
    
    convenience init(dict: [String: AnyObject]) {
        self.init()
        self.furnishingDesc = dict["furnishingDesc"] as? String ?? ""
        self.rent = dict["rent"] as? Int ?? 0
        self.propertySize = dict["propertySize"] as? Int ?? 0
        self.bathroom = dict["bathroom"] as? Int ?? 0
        self.propertyTitle = dict["title"] as? String ?? ""
        self.locality = dict["secondaryTitle"] as? String ?? ""
        guard let pics = dict["photos"] as? [[String: AnyObject]] else { return }
        guard let firstImage = pics.first, let images = firstImage["imagesMap"] as? [String: String] else { return }
        self.displayPic = images["medium"] ?? ""
    }
}
