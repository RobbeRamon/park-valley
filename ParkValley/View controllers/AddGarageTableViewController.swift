//
//  AddGarageTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 21/12/2020.
//

import UIKit
import MapKit
import CoreLocation

class AddGarageTableViewController: UITableViewController {
    
    @IBOutlet var tvDescription: UITextView!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfLocation: UITextField!
    @IBOutlet var ivGarageImage: UIImageView!
    
    private let locationManager = CLLocationManager()
    private let imagePicker = UIImagePickerController()
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    @IBAction func tgCurrentLocationTapped(_ sender: Any) {
        
        // ask the user
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    

    
    // MARK: - Helper functions
    
    private func createUI() {
        tvDescription.layer.borderColor = UIColor.systemGray3.cgColor
        tvDescription.layer.cornerRadius = 5
        tvDescription.layer.borderWidth = 0.5
        
        
        
    }

}

extension AddGarageTableViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        //print("locations = \(location.latitude) \(location.longitude)")
        
        self.longitude = location.longitude
        self.latitude = location.latitude
        
        
        lookUpCurrentLocation(completionHandler: {(placemark: CLPlacemark?) -> Void in
            if let placemark = placemark {
                
                let locationString = "\(placemark.thoroughfare!) \(placemark.subThoroughfare!), \(placemark.locality!) \(placemark.postalCode!), \(placemark.country!)"
                self.tfLocation.text = locationString
            }
            
        })
    }
    
    
    // SOURCE: https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}

extension AddGarageTableViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func tgAddPictureTapped(_ sender: UIView) {
        imagePicker.delegate = self
        
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
            alertController.addAction(photoLibraryAction)
        }
        

        
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage
        else {return}
        
        ivGarageImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
