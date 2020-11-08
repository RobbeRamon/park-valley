//
//  LoginViewController.swift
//  ParkValley
//
//  Created by Robbe on 08/11/2020.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {

    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var viewAnimation: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    var pAnimationView: AnimationView?
    var backgroundAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()

    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let user = User(id: "id", username: txtEmail.text!, token: "token")
        User.saveToFile(user)
        
        performSegue(withIdentifier: "sgShowApplication", sender: self)
    }
    
    
    private func createUI () {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
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
