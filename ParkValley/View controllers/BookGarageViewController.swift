//
//  BookGarageViewController.swift
//  ParkValley
//
//  Created by Robbe on 19/12/2020.
//

import UIKit
import Lottie

class BookGarageViewController: UIViewController {

    @IBOutlet var btGetResults: UIButton!
    @IBOutlet var dpFrom: UIDatePicker!
    @IBOutlet var dpTo: UIDatePicker!
    @IBOutlet var tvAvailableDates: UITableView!
    @IBOutlet var lbTitle: UILabel!
    
    
    private var garageModelController = GarageModelController()
    private var availableDates: [Date] = []
    private var booking: Booking?
    
    
    var garage: Garage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvAvailableDates.dataSource = self
        self.tvAvailableDates.delegate = self
        
        createUI()
        updateUI()
    }
    

    /// Get the available dates from the daterange given by the user
    @IBAction func btGetResultsClicked(_ sender: Any) {
        let group = DispatchGroup()
        
        if let garage = garage {
            let dateRange = DateRangeDTO(name: garage.name ?? "", startDate: dpFrom.date, endDate: dpTo.date)
            
            group.enter()
            
            if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
                
                garageModelController.fetchAvailableDates(garage: self.garage!, token: bearerToken, dateRange: dateRange, completion: {
                    (availableDates) in
                    
                    self.availableDates = availableDates
                    group.leave()
                })
            }
            
            group.notify(queue: .main) {
                self.updateUI()
                
                if self.availableDates.isEmpty {
                    let label : UILabel = UILabel()
                    label.text = "No available dates found"
                    label.textAlignment = .center
                    label.textColor = .gray
                    
                    self.tvAvailableDates.backgroundView = label
                } else {
                    self.tvAvailableDates.backgroundView = nil
                }
            }
        }
        
       
    }
    
    /// Checks if the app is in landscape mode or not
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            btGetResults.layer.borderWidth = 0
        } else {
            btGetResults.layer.borderWidth = 0.5
        }
    }

    
    // MARK: - Helper functions
    private func updateUI() {
        lbTitle.text = garage?.name
        tvAvailableDates.reloadData()
        
        if !self.availableDates.isEmpty {
            self.tvAvailableDates.backgroundView = nil
        }
    }
    
    private func createUI() {
        var dateComponent = DateComponents()
        dateComponent.day = 5
        
        dpFrom.minimumDate = Date()
        dpFrom.maximumDate = Calendar.current.date(byAdding: dateComponent, to: Date())

        dpTo.maximumDate = Calendar.current.date(byAdding: dateComponent, to: Date())
        
        dpTo.minimumDate = Date()
        
        btGetResults.layer.cornerRadius = 10
        btGetResults.layer.borderWidth = 0.5
        btGetResults.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    /// Alert a success message
    private func showSucess() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let dateString = dateFormatter.string(for: self.booking?.date)
        
        if let dateString = dateString {
            
            let alert = UIAlertController(
                title: "Success",
                message: "Booking is succssfully added at \(dateString)",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }

    }

}

extension BookGarageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return availableDates.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath) as! AvailableDayTableViewCell
        
        cell.update(date: availableDates[indexPath.row])
        
        return cell
    }
    
}

extension BookGarageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = availableDates[indexPath.row]

        let group = DispatchGroup()

        if let garage = garage {

            group.enter()

            if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {

                garageModelController.addBooking(garage: garage, token: bearerToken, date: date, completion: {
                    (booking) in
                    
                    self.booking = booking
                    group.leave()
                })
            }

            group.notify(queue: .main) {
                self.showSucess()
            }
        }
    }
}

