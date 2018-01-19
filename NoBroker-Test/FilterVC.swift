//
//  ViewController.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/16/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {
    
    
    @IBOutlet weak var apartmentButton: FilterButton!
    @IBOutlet weak var iHButoon: FilterButton!
    @IBOutlet weak var iFButton: FilterButton!
    @IBOutlet weak var fullFurnishedButton: FilterButton!
    @IBOutlet weak var semiFurnished: FilterButton!
    @IBOutlet weak var threeBhkButton: FilterButton!
    @IBOutlet weak var fourBhkButton: FilterButton!
    @IBOutlet weak var twoBhkButton: FilterButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func filterChanged(_ sender: FilterButton) {
        if sender.isFilter {
            sender.unSelected()
        } else {
           sender.selected()
        }
    }

    @IBAction func ApplyTapped(_ sender: Any) {
        
        var propertyType = twoBhkButton.isFilter || threeBhkButton.isFilter || fourBhkButton.isFilter ? "&type=" : ""
        var propertyTypeFilters = [String]()
        if twoBhkButton.isFilter {
            propertyTypeFilters.append("BHK2")
        }
        if threeBhkButton.isFilter {
            propertyTypeFilters.append("BHK3")
        }
        if fourBhkButton.isFilter {
            propertyTypeFilters.append("BHK4")
        }
        propertyType.append(propertyTypeFilters.joined(separator: "/"))
        
        var buildingType = apartmentButton.isFilter || iHButoon.isFilter || iFButton.isFilter ? "&buildingType=" : ""
        var buildingTypeFilters = [String]()
        if apartmentButton.isFilter {
            buildingTypeFilters.append("AP")
        }
        if iHButoon.isFilter {
            buildingTypeFilters.append("IH")
        }
        if iFButton.isFilter {
            buildingTypeFilters.append("IF")
        }
        buildingType.append(buildingTypeFilters.joined(separator: "/"))

        
        var furnishing = semiFurnished.isFilter || fullFurnishedButton.isFilter ? "&furnishing=" : ""
        var furnishingFilters = [String]()
        if semiFurnished.isFilter {
            furnishingFilters.append("SEMI_FURNISHED")
        }
        if fullFurnishedButton.isFilter {
            furnishingFilters.append("FULLY_FURNISHED")
        }
        furnishing.append(furnishingFilters.joined(separator: "/"))

        
         UserDefaults.standard.setValue(propertyType, forKey: "propertyType")
         UserDefaults.standard.setValue(buildingType, forKey: "buildingType")
         UserDefaults.standard.setValue(furnishing, forKey: "furnishing")
        
        dismiss(animated: true)
    }
    
}

