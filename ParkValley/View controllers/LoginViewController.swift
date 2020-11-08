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
    
    var animationView: AnimationView?
    var backgroundAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawUI()

    }
    
    
    private func drawUI () {
        btnLogin.layer.cornerRadius = 10

        animationView = .init(name:"parking-icon")
        animationView?.frame = viewAnimation.bounds
        animationView?.loopMode = .autoReverse
        viewAnimation.addSubview(animationView!)
        animationView?.play()
        
        viewAnimation.sendSubviewToBack(animationView!)

        backgroundAnimationView = .init(name:"login-background")
        backgroundAnimationView?.frame = view.bounds
        backgroundAnimationView?.loopMode = .loop
        backgroundAnimationView?.animationSpeed = 0.5
        view.addSubview(backgroundAnimationView!)
        backgroundAnimationView?.play()
        view.sendSubviewToBack(backgroundAnimationView!)
        
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
