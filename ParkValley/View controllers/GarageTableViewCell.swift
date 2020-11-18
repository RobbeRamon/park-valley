//
//  GarageTableViewCell.swift
//  ParkValley
//
//  Created by Robbe on 19/11/2020.
//

import UIKit
import Cards

class GarageTableViewCell: UITableViewCell {
    @IBOutlet var vwGarage: UIView!
    
    var card: CardArticle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        card = CardArticle(frame: vwGarage.bounds)
        card.backgroundImage = UIImage(named: "new-york-wallpaper-blurred-darkened")
        card.textColor = UIColor.white
        
        vwGarage.addSubview(card)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with garage: Garage) {
        card.title = garage.name!
        card.category = garage.city!
        card.subtitle = ""
    }

}
