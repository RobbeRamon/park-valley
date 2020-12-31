//
//  RegisterTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 31/12/2020.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet var lbEmail: UITextField!
    @IBOutlet var lbUsername: UITextField!
    @IBOutlet var lbPassword1: UITextField!
    @IBOutlet var lbPassword2: UITextField!
    @IBOutlet var lbErrorMessage: UILabel!
    
    var registered = false
    
    private var userModelController = UserModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func doneClicked(_ sender: Any) {
        if validateForm() {
            let registerDTO = RegisterDTO(email: lbEmail.text!, username: lbUsername.text!, password: lbPassword1.text!, confirmPassword: lbPassword2.text!)
            
            let group = DispatchGroup()
            
            group.enter()
            
            userModelController.register(user: registerDTO, completion: {(user) in
                if user?.email == nil  {
                    self.registered = false
                    group.leave()
                } else {
                    self.registered = true
                    group.leave()
                }
            })
            
            group.notify(queue: .main) {
                
                if self.registered {
                    
                    let alert = UIAlertController(title: "Account registered", message: "Your account is successfully registered", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.lbErrorMessage.text = "Account creation had failed"
                    self.lbErrorMessage.isHidden = false
                }
                
                
            }
            
        }
    }
    
    // MARK: - Helper methods
    private func validateForm() -> Bool {
        if lbEmail.text!.isEmpty || lbUsername.text!.isEmpty || lbPassword1.text!.isEmpty || lbPassword2.text!.isEmpty {
            lbErrorMessage.text = "All fields are required"
            lbErrorMessage.isHidden = false
            return false
        } else if lbPassword1.text! != lbPassword2.text! {
            lbErrorMessage.text = "Passwords do not match"
            lbErrorMessage.isHidden = false
            return false
        } else {
            lbErrorMessage.isHidden = true
            return true
        }
    }
}
