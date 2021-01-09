//
//  GarageTableViewCell.swift
//  ParkValley
//
//  Created by Robbe on 19/11/2020.
//

import UIKit

class GarageTableViewCell: UITableViewCell {
    @IBOutlet var lbGarageName: UILabel!
    @IBOutlet var lbGarageCity: UILabel!
    @IBOutlet var lbGarageImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with garage: Garage) {
        lbGarageName.text = garage.name
        lbGarageCity.text = garage.city
    }
    
}
