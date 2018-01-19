//
//  ListVM.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/17/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import Foundation

class PropertyListVM {
    
    var propertyLists = [PropertyModel]()
    
    init() {}
    
    func getPropertyLists(pageUrl: String, completion: @escaping (_ isSuccess: Bool, _ error: String) -> Void) {

        guard let proprtyListUrl = URL(string: pageUrl) else { return }
        let request = URLRequest(url: proprtyListUrl)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (responseData, urlResponse, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                do {
                    guard let dictonary = try JSONSerialization.jsonObject(with: responseData!, options: []) as? [String:AnyObject] else { return }
                    guard let data = dictonary["data"] as? [[String: AnyObject]] else { return }
                    for item in data {
                        let property = PropertyModel(dict: item)
                        print(property)
                        self.propertyLists.append(property)
                        completion(true, "")
                    }
                } catch {
                    print("error, while trying to convert data to JSON")
                    return
                }
            }
            }.resume()
    }
}
