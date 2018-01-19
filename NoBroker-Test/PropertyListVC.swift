//
//  ListVC.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/17/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import UIKit

class PropertyListVC: UIViewController {
    
    @IBOutlet weak var propertyListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let propertyPageUrl1 = "http://www.nobroker.in/api/v1/property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/?lat_lng=12.9279232,77.6271078&rent=0,500000&travelTime=30&pageNo=1"
    
    private let propertyPageUrl2 = "http://www.nobroker.in/api/v1/property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/?lat_lng=12.9279232,77.6271078&rent=0,500000&travelTime=30&pageNo=2"
    
    var propertyListVM: PropertyListVM!
    var filter: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        propertyListVM = PropertyListVM()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let propertyType =  UserDefaults.standard.value(forKey: "propertyType") as? String ?? ""
        let buildingType =  UserDefaults.standard.value(forKey: "buildingType") as? String ?? ""
        let furnishing =  UserDefaults.standard.value(forKey: "furnishing") as? String ?? ""
        filter = propertyType + buildingType + furnishing
        var pageUrl = propertyPageUrl1
        pageUrl.append(filter)
        fetchPropertyLists(propertyPageUrl: pageUrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.setValue("", forKey: "propertyType")
         UserDefaults.standard.setValue("", forKey: "buildingType")
         UserDefaults.standard.setValue("", forKey: "furnishing")
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        UserDefaults.standard.setValue("", forKey: "propertyType")
        UserDefaults.standard.setValue("", forKey: "buildingType")
        UserDefaults.standard.setValue("", forKey: "furnishing")
    }
    func fetchPropertyLists(propertyPageUrl: String) {
        propertyListVM.getPropertyLists(pageUrl: propertyPageUrl, completion: { [weak self] isSuccess, error in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.propertyListTableView.reloadData()
                }
            } else {
                self?.showAlert(message: error)
            }
        })
    }
    
    private func showAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}

extension PropertyListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyListVM.propertyLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == propertyListVM.propertyLists.count - 1 && propertyListVM.propertyLists.count < 42{
            var pageUrl2 = propertyPageUrl2
            pageUrl2.append(filter)
            self.fetchPropertyLists(propertyPageUrl: pageUrl2)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PropertyListTableViewCell.self)") as! PropertyListTableViewCell
        let property = propertyListVM.propertyLists[indexPath.row]
        cell.configureCell(property: property)
        return cell
    }
}
