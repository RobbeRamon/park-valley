//
//  PrototypeSettingsViewController.swift
//  ParkValley
//
//  Created by Robbe on 01/01/2021.
//

import UIKit

class PrototypeSettingsViewController: UIViewController {
    
    let garageModelController = GarageModelController()
    let userModelController = UserModelController()
    var status: StatusDTO? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetBackendClicked(_ sender: Any) {
        let group = DispatchGroup()
        

            
        group.enter()
        userModelController.resetBackend(completion: {(status) in
            
            if let status = status {
                self.status = status
            }
            
            group.leave()
        })
        
        group.notify(queue: .main) {
            if let status = self.status {
                if status.success {
                    self.showPopup(
                        title: "Backend cleared",
                        message: "The backend is now cleared, the state has returned to the initial state with inital data.")
                } else {
                    self.showPopup(
                        title: "Backend not cleared",
                        message: "Something went wrong.")
                }
                
            } else {
                self.showPopup(
                    title: "Backend not cleared",
                    message: "Something went wrong.")
            }
        }
    }
    
    @IBAction func clearCacheClicked(_ sender: Any) {
        garageModelController.removeHistoryFromFile()
        showPopup(
            title: "Cache cleared",
            message: "Your cache is now cleared, the recently visited section should be empty now.")
    }
    
    // MARK: - Helper methods
    
    /// Show a popup with a message and a title
    private func showPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            // do nothing
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
