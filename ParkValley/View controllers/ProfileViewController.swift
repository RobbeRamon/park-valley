//
//  ProfileViewController.swift
//  ParkValley
//
//  Created by Robbe on 20/12/2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var ivProfilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    // MARK: - Helper functions
    private func createUI() {
        ivProfilePicture.layer.masksToBounds = false
        ivProfilePicture.layer.cornerRadius = ivProfilePicture.frame.height/2
        ivProfilePicture.clipsToBounds = true
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
