//
//  BookingTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 01/01/2021.
//

import UIKit

class BookingTableViewController: UITableViewController {
    
    var bookings: [BookingDTO] = []
    let bookingModelController = BookingModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        
        if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
            
            if let user = User.loadFromFile() {
                
                bookingModelController.fetchBookings(userId: user.id!, token: bearerToken, completion: {
                    (bookings) in
                    
                    self.bookings = bookings
                    group.leave()
                })
                
            }
            
        }
        
        group.notify(queue: .main) {
            self.updateUI()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookings.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "booking", for: indexPath)
        
        let booking = bookings[indexPath.row]
        cell.textLabel!.text = booking.name
        cell.detailTextLabel!.text = dateFormatter.string(from: booking.date)
        
        return cell
    }
    
    // MARK: - Helper methods
    
    private func updateUI() {
        self.tableView.reloadData()
        
        if self.bookings.isEmpty {
            let label : UILabel = UILabel()
            label.text = "Nothing found"
            label.textAlignment = .center
            label.textColor = .gray
            
            self.tableView.backgroundView = label
        } else {
            
            self.tableView.backgroundView = nil
            
        }
    }

}
