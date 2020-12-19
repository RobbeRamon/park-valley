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
    @IBOutlet var csViewHeight: NSLayoutConstraint!
    @IBOutlet var tvHistory: UITableView!
    
    private var history : [Garage] = []
    private var garageModelController: GarageModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        garageModelController = GarageModelController()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper methods
    func updateUI() {
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

}

extension TestViewController: UITableViewDataSource {
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
