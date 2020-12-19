//
//  BookGarageViewController.swift
//  ParkValley
//
//  Created by Robbe on 19/12/2020.
//

import UIKit

class BookGarageViewController: UIViewController {

    @IBOutlet var btGetResults: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    // MARK: - Helper methods
    
    func createUI() {
        btGetResults.layer.cornerRadius = 10
        btGetResults.layer.borderWidth = 0.5
        btGetResults.layer.borderColor = UIColor.systemBlue.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
