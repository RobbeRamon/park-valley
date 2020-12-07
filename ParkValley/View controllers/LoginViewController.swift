//
//  LoginViewController.swift
//  ParkValley
//
//  Created by Robbe on 08/11/2020.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet var cBottom: NSLayoutConstraint!
    
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var viewAnimation: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var lblErrorMessage: UILabel!
    
    var pAnimationView: AnimationView?
    var backgroundAnimationView: AnimationView?
    var userModelController: UserModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userModelController = UserModelController()
        createUI()
        registerForKeyboardNotifications()

    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        getAndSaveToken()
    }
    
    /**
     Get token and save to default storage followed by get user
     */
    private func getAndSaveToken() {
        let group = DispatchGroup()
        
        group.enter()
        userModelController.login(username: txtEmail.text!, password: txtPassword.text!, completion: {(userTokenDTO) in
            
            if let bearerToken = userTokenDTO?.value {
                UserDefaults.standard.set(bearerToken, forKey: "bearer-token")
            }
            
            group.leave()
        })
        
        group.notify(queue: .main) {
            self.getAndSaveUser()
        }
    }
    
    /**
     Get user and save to file
     */
    private func getAndSaveUser() {
        let group = DispatchGroup()
        
        if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
            
            UserDefaults.standard.removeObject(forKey: "bearer-token")
            
            group.enter()
            userModelController.fetchUser(token: bearerToken, completion: {(user) in
                
                if let user = user {
                    User.saveToFile(user)
                }
                
                group.leave()
            })
            
            group.notify(queue: .main) {
                self.navigateToApplication()
            }
        } else {
            lblErrorMessage.isHidden = false
        }
    }
    
    private func navigateToApplication() {
        performSegue(withIdentifier: "sgShowApplication", sender: self)
    }
    
    private func createUI () {
        btnLogin.layer.cornerRadius = 10

        pAnimationView = .init(name:"parking-icon")
        pAnimationView?.frame = viewAnimation.bounds
        pAnimationView?.loopMode = .autoReverse
        viewAnimation.addSubview(pAnimationView!)
        pAnimationView?.play()
        viewAnimation.sendSubviewToBack(pAnimationView!)

        backgroundAnimationView = .init(name:"login-background")
        backgroundAnimationView?.frame = view.bounds
        backgroundAnimationView?.loopMode = .loop
        backgroundAnimationView?.animationSpeed = 0.5
        view.addSubview(backgroundAnimationView!)
        backgroundAnimationView?.play()
        view.sendSubviewToBack(backgroundAnimationView!)
        
        lblErrorMessage.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - shift view when keyboard is shown
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
              let _ = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        viewAnimation.isHidden = true
        cBottom.constant = 650
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        viewAnimation.isHidden = false
        
        cBottom.constant = 450
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    // MARK: - helper methods
    
    private func validate()  {
        
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
