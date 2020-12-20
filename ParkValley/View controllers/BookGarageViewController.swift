//
//  BookGarageViewController.swift
//  ParkValley
//
//  Created by Robbe on 19/12/2020.
//

import UIKit

class BookGarageViewController: UIViewController {

    @IBOutlet var btGetResults: UIButton!
    @IBOutlet var dpFrom: UIDatePicker!
    @IBOutlet var dpTo: UIDatePicker!
    @IBOutlet var tvAvailableDates: UITableView!
    @IBOutlet var lbTitle: UILabel!
    
    private var garageModelController = GarageModelController()
    private var availableDates: [Date] = []
    
    var garage: Garage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvAvailableDates.dataSource = self
        
        createUI()
        updateUI()
    }
    
    // MARK: - Helper methods
    func createUI() {
        btGetResults.layer.cornerRadius = 10
        btGetResults.layer.borderWidth = 0.5
        btGetResults.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func btGetResultsClicked(_ sender: Any) {
        let group = DispatchGroup()
        
        if let garage = garage {
            let dateRange = DateRangeDTO(name: garage.name ?? "", startDate: dpFrom.date, endDate: dpTo.date)
            
            group.enter()
            
            if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
                
                garageModelController.fetchAvailableDates(garage: self.garage!, token: bearerToken, dateRange: dateRange, completion: {(availableDates) in
                    self.availableDates = availableDates
                    group.leave()
                })
            }
            
            group.notify(queue: .main) {
                self.updateUI()
            }
        }
        
       
    }
    
    // MARK: - Helper functions
    private func updateUI() {
        lbTitle.text = garage?.name
        tvAvailableDates.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        
        cell.textLabel?.text = formatter.string(from: availableDates[indexPath.row])
        
        return cell
    }
    
}

