//
//  FilterButton.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/18/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import UIKit

class FilterButton: UIButton {
    
    var isFilter = false

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0).cgColor
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
    }
    
    func unSelected() {
        titleLabel?.textColor = UIColor.darkGray
        layer.borderColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0).cgColor
        isFilter = false
    }
    
    func selected() {
        titleLabel?.textColor =  UIColor(red: 255.0/255.0, green: 98.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        layer.borderColor =  UIColor(red: 255.0/255.0, green: 98.0/255.0, blue: 83.0/255.0, alpha: 1.0).cgColor
        isFilter = true
    }
}
