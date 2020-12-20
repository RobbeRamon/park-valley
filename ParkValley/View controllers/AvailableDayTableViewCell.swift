//
//  AvailableDayTableViewCell.swift
//  ParkValley
//
//  Created by Robbe on 20/12/2020.
//

import UIKit

class AvailableDayTableViewCell: UITableViewCell {
    
    @IBOutlet var lbDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbDay.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        
        lbDay.text = formatter.string(from: date)
    }

}
