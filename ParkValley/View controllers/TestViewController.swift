//
//  TestViewController.swift
//  ParkValley
//
//  Created by Robbe on 09/11/2020.
//

import UIKit
import Cards

class TestViewController: UIViewController {
    @IBOutlet var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aspect Ratio of 5:6 is preferred
        let card = CardHighlight(frame: view2.bounds)
        

        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
        card.backgroundImage = UIImage(named: "new-york-wallpaper-blurred-darkened")
        card.title = "Search nearby garages"
        card.itemSubtitle = ""
        card.itemTitle = ""
        card.buttonText = ""
        card.titleSize = 30
        card.textColor = UIColor.white
            
        
        card.hasParallax = true
            
//        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
//        card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            
        view2.addSubview(card)
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
