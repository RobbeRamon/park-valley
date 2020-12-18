//
//  GarageDetailViewController.swift
//  ParkValley
//
//  Created by Robbe on 23/11/2020.
//

import UIKit
import MapKit

class GarageDetailViewController: UIViewController {
    
    @IBOutlet var niName: UINavigationItem!
    @IBOutlet var scrollView: UIScrollView!
    
    var garage: Garage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height);
        updateUI()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowOnMap" {
            let garageShowMapViewController = segue.destination as! GarageShowMapViewController
            
            garageShowMapViewController.garage = self.garage
        }
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            niName.title = garage.name
        }
    }

}
