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
            
            niNavbar.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGarageTapped))

        case .unknown:
            niNavbar.title = "Garages"
        case .booked:
            niNavbar.title = "Booked garages"
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // can not be done in viewDidLoad for the best UX
        fetchGarages()
    }
    
    @objc private func addGarageTapped() {
        performSegue(withIdentifier: "sgAddGarage", sender: self)
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
            
            
            if let user = User.loadFromFile() {
                
                switch garageListType {
                
                case .favorite:
                    
                    garageModelController.fetchFavouriteGarages(userId: user.id!, token: bearerToken, completion: {(garages) in
                        self.garages = garages
                        group.leave()
                    })
                    
                case .owned:
                    
                    garageModelController.fetchOwnedGarages(userId: user.id!, token: bearerToken, completion: {(garages) in
                        self.garages = garages
                        group.leave()
                    })
                    
                case .unknown:
                    break;
                case .booked:
                    break;
                    
                }
                
                
            }
            
        }
        
        group.notify(queue: .main) {
            self.updateUI()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            let garage = garages[indexPath.row]
            self.garages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
                
                garageModelController.removeGarage(garage: garage, token: bearerToken, completion: {(success) in
                    
                    if !success {
                        
                        let alert = UIAlertController(title: "Error", message: "Could not remove the garage", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                })
                
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
        

    }
    
    private func updateUI() {
        self.tableView.reloadData()
        
        if self.garages.isEmpty {
            let label : UILabel = UILabel()
            label.text = "Nothing found"
            label.textAlignment = .center
            label.textColor = .gray
            
            tableView.backgroundView = label
        } else {
            self.tableView.backgroundView = nil
        }
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
