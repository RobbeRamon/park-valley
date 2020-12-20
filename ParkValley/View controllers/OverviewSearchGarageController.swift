//
//  TestViewController.swift
//  ParkValley
//
//  Created by Robbe on 09/11/2020.
//

import UIKit
import Lottie

class OverviewSearchGarageController: UIViewController {
    @IBOutlet var tgSearchNearby: UITapGestureRecognizer!
    @IBOutlet var ivSearchNearby: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var csViewHeight: NSLayoutConstraint!
    @IBOutlet var tvHistory: UITableView!
    @IBOutlet var vwAnimation: UIView!
    
    private var history : [Garage] = []
    private var garageModelController: GarageModelController = GarageModelController()
    var cAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvHistory.dataSource = self
        
        createUI()
        
        //history = garageModelController.loadHistoryFromFile() ?? []
        //updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        history = garageModelController.loadHistoryFromFile() ?? []
        updateUI()
    }
    

    
    /// This is necessary, otherwise a constraint error is thrown
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if (csViewHeight != nil) {
            csViewHeight.isActive = false
        }


    }
    
    override func viewWillLayoutSubviews() {
        csViewHeight.isActive = true
    }
    

    
    @IBAction func handleSearchNearbyClick(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "sgShowSearchGarages", sender: self)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowDetail" {
            let indexPath = tvHistory.indexPathForSelectedRow!
            let garage = history[indexPath.row]
            let garageDetailViewController = segue.destination as! GarageDetailViewController
            
            garageDetailViewController.garage = garage
        }
    }

    
    
    // MARK: - Helper methods
    func updateUI() {
        cAnimationView?.play()
        
        tvHistory.reloadData()
        
        
        if self.history.isEmpty {
            let label : UILabel = UILabel()
            label.text = "Your history is empty"
            label.textAlignment = .center
            label.textColor = .gray
            
            tvHistory.backgroundView = label
        } else {
            tvHistory.backgroundView = nil
        }
    }
    
    func createUI() {
        cAnimationView = .init(name:"click")
        cAnimationView?.frame = vwAnimation.bounds
        cAnimationView?.loopMode = .loop
        cAnimationView?.animationSpeed = 1
        vwAnimation.addSubview(cAnimationView!)
        cAnimationView?.play()
        vwAnimation.sendSubviewToBack(cAnimationView!)
    }

}

extension OverviewSearchGarageController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return history.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garage", for: indexPath) as! GarageTableViewCell
        
        let garage = history[indexPath.row]
        cell.update(with: garage)
        
        return cell
    }
    
}
