//
//  TestViewController.swift
//  ParkValley
//
//  Created by Robbe on 09/11/2020.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet var tgSearchNearby: UITapGestureRecognizer!
    @IBOutlet var ivSearchNearby: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aspect Ratio of 5:6 is preferred
//        let card = CardHighlight(frame: view2.bounds)
//
//
//        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
//        card.backgroundImage = UIImage(named: "new-york-wallpaper-blurred-darkened")
//        card.title = "Search nearby garages"
//        card.itemSubtitle = ""
//        card.itemTitle = ""
//        card.buttonText = ""
//        card.titleSize = 30
//        card.textColor = UIColor.white
//
//        card.hasParallax = true
//
//
//        //card.gestureRecognizers?.append(tgSearchNearby)
//        view2.addSubview(card)
        
        
        //ivSearchNearby.gestureRecognizers?.append(tgSearchNearby)        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height);
    }
    
    @IBAction func handleSearchNearbyClick(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "sgShowSearchGarages", sender: self)
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
