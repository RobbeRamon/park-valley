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
    @IBOutlet var lbGarageName: UILabel!
    @IBOutlet var lbGarageCity: UILabel!
    @IBOutlet var lbGarageImage: UIImageView!
    
    private var card: CardArticle!
//    private var gestureRecognizer: UITapGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
            
//        card = CardArticle(frame: vwGarage.bounds)
//        card.backgroundImage = UIImage(named: "new-york-wallpaper-blurred-darkened")
//        card.textColor = UIColor.white
//        card.titleSize = 35
//        card.category = ""
//        card.shadowOpacity = 0
        
//        gestureRecognizer = UITapGestureRecognizer()
        
        /// Add tab gesture to card
//        gestureRecognizer.addTarget(self, action: #selector(self.cardClicked(_:forEvent:)))
//        card.gestureRecognizers?.append(gestureRecognizer)
        
        //card.isUserInteractionEnabled = true
        
        //self.contentView.isUserInteractionEnabled = false;
        
        //vwGarage.addSubview(card)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with garage: Garage) {
//        card.title = garage.name!
//        card.subtitle = garage.city!
        lbGarageName.text = garage.name
        lbGarageCity.text = garage.city
        
        
    }
    
//    @objc func cardClicked(_ sender: Any, forEvent event: UIEvent){
//
//    }
    
}
