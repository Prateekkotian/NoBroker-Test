//
//  PropertyListTableViewCell.swift
//  NoBroker-Test
//
//  Created by Prateek kumar on 1/18/18.
//  Copyright © 2018 Prateek kumar. All rights reserved.
//

import UIKit

class PropertyListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var furnishedLabel: UILabel!
    @IBOutlet weak var propertySizeLabel: UILabel!
    @IBOutlet weak var bathRoomslabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView! {
        didSet {
            backgroundCardView.layer.cornerRadius = 3.0
            backgroundCardView.layer.masksToBounds = false
            backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            backgroundCardView.layer.shadowOpacity = 0.8
            
        }
    }
    
    private let baseImageurl = "http://d3snwcirvb4r88.cloudfront.net/images/"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(property: PropertyModel) {
        contentView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.selectionStyle = .none
        titleLabel.text = property.propertyTitle
        localityLabel.text = property.locality
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .decimal
        rentLabel.text = "₹" + " " + formatter.string(from: NSNumber(value: property.rent))!
        propertySizeLabel.text = String(property.propertySize) + " " + "Sq.ft"
        bathRoomslabel.text = String(property.bathroom) + " bathrooms"
        furnishedLabel.text = property.furnishingDesc + " Furnished"
        let path = property.displayPic.split(separator: "_", maxSplits: 1, omittingEmptySubsequences: true)
        guard let token = path.first else { return }
        let imageUrl = baseImageurl + String(describing: token) + "/" + property.displayPic
        self.loadImage(imageUrlString: imageUrl , completion: { [weak self] isLoaded, image in
            DispatchQueue.main.async {
                self?.displayImage.image = image
            }
        })
    }
    
    func loadImage(imageUrlString: String, completion: @escaping (_ isLoaded: Bool, _ image: UIImage) -> Void) {
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: TimeInterval(20))
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (responseData, urlResponse, error) in
            print(error?.localizedDescription ?? "")
            guard urlResponse != nil, let imageData = responseData else {
                return
            }
            guard let image = UIImage(data: imageData) else { return }
            completion(true, image)
            }.resume()
    }
}
