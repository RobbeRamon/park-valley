//
//  SearchGarageTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 16/11/2020.
//

import UIKit

class SearchGarageTableViewController: UITableViewController {
    
    private var results : [Garage] = []
    private var searchTerm : String = ""
    private var garageModelController = GarageModelController()
    
    @IBOutlet var sbSearch: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sbSearch.delegate = self
        sbSearch.becomeFirstResponder()
        
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let garage = results[indexPath.row]
            let garageDetailViewController = segue.destination as! GarageDetailViewController
            
            garageDetailViewController.garage = garage
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return results.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garage", for: indexPath) as! GarageTableViewCell
        
        let garage = results[indexPath.row]
        cell.update(with: garage)
        
        return cell
    }
    
    // MARK: - Helper methods
    private func updateUI() {
        self.tableView.reloadData()
        
        
        if self.results.isEmpty {
            let label : UILabel = UILabel()
            label.text = "Nothing found"
            label.textAlignment = .center
            label.textColor = .gray
            
            self.tableView.backgroundView = label
        } else {
            
            self.tableView.backgroundView = nil
            
        }
    }
    
    /// Gets the garage from the backend using the search term
    private func search(_ searchTerm: String) {
        let group = DispatchGroup()
        
        group.enter()
        
        if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
            garageModelController.fetchGarages(searchTerm: searchTerm, token: bearerToken, completion: {
                (garages) in
                
                self.results = garages
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            self.updateUI()
        }
    }

}

extension SearchGarageTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text!)
    }
}
