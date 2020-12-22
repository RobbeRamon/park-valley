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
    private var placemark: CLPlacemark?
    
    private var garageModelController = GarageModelController()
    
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
    
    @IBAction func save(_ sender: Any) {
        if (allFieldsFilled() && placemark != nil) {
            let garage = Garage(id: nil, name: tfName.text!, city: placemark!.locality!, description: tvDescription.text!, latitude: self.latitude, longitude: self.longitude, user: nil, favorite: false)
            
            
            let group = DispatchGroup()
            
                
            group.enter()
            
            if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
                
                garageModelController.addGarage(garage: garage, token: bearerToken, completion: {(garage: Garage?) -> Void in
                    group.leave()
                })
            }
            
            group.notify(queue: .main) {
                
                let alert = UIAlertController(title: "Garage saved", message: "You have added a new garage", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        } else {
            
            let alert = UIAlertController(title: "Empty fields", message: "Please fill every field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper functions
    
    private func createUI() {
        tvDescription.layer.borderColor = UIColor.systemGray3.cgColor
        tvDescription.layer.cornerRadius = 5
        tvDescription.layer.borderWidth = 0.5
    }
    
    private func allFieldsFilled() -> Bool {
        return !(tfName.text!.isEmpty || tvDescription.text!.isEmpty || tfLocation.text!.isEmpty)
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
                self.placemark = placemark
                
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
