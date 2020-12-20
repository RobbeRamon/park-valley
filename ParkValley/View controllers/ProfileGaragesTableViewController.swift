//
//  ProfileGaragesTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 20/12/2020.
//

import UIKit

class ProfileGaragesTableViewController: UITableViewController {
    
    var garageListType: GarageListType = .unknown
    
    @IBOutlet var niNavbar: UINavigationItem!
    
    private var garages: [Garage] = []
    private var garageModelController = GarageModelController()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch garageListType {
        case .favorite:
            niNavbar.title = "Favorite garages"
        case .owned:
            niNavbar.title = "My garages"
        case .unknown:
            niNavbar.title = "Garages"
        case .booked:
            niNavbar.title = "Booked garages"
        }
        
        fetchGarages()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return garages.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garage", for: indexPath) as! GarageTableViewCell
        
        let garage = garages[indexPath.row]
        cell.update(with: garage)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let garage = garages[indexPath.row]
            let garageDetailViewController = segue.destination as! GarageDetailViewController
            
            garageDetailViewController.garage = garage
        }
    }
    
    // MARK: - Helper functions
    private func fetchGarages() {
        let group = DispatchGroup()
        
        group.enter()
        
        if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
            garageModelController.fetchGarages(searchTerm: "Ghent", token: bearerToken, completion: {(garages) in
                self.garages = garages
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        self.tableView.reloadData()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
