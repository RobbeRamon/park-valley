//
//  GarageDetailViewController.swift
//  ParkValley
//
//  Created by Robbe on 23/11/2020.
//

import UIKit
import MapKit

class GarageDetailViewController: UIViewController {
    
    @IBOutlet var niName: UINavigationItem!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var ivImage: UIImageView!
    @IBOutlet var mvLocation: MKMapView!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var btBook: UIButton!
    
    @IBOutlet var csViewHeight: NSLayoutConstraint!
    @IBOutlet var heartGarage: UIBarButtonItem!
    
    var garage: Garage?
    let locationManager = CLLocationManager()
    let garageModelController = GarageModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGarageToHistory()
        createUI()
        updateUI()
        updateHeart()
    }
    
    
    @IBAction func favorGarageClicked(_ sender: Any) {
        
        if garage!.favorite != nil {
            garage!.favorite = !garage!.favorite!
        } else {
            garage!.favorite = true
        }
        
        
        if let bearerToken = UserDefaults.standard.string(forKey: "bearer-token") {
            
            garageModelController.switchFavor(garage: garage!, token: bearerToken, completion: {(success) in
                
                if !success {
                    
                    let alert = UIAlertController(title: "Error", message: "Could not favor the garage", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            })
            
        }
        
        updateHeart()
        

    }
    
    @IBAction func btnOpenInMapsClicked(_ sender: Any) {
        openMapForPlace()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowOnMap" {
            let garageShowMapViewController = segue.destination as! GarageShowMapViewController
            garageShowMapViewController.garage = self.garage
        }
        
        if segue.identifier == "sgBookGarage" {
            let bookGarageViewController = segue.destination as! BookGarageViewController
            bookGarageViewController.garage = self.garage
        }
    }
    
    /// This is necessary, otherwise a constraint error is thrown
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        csViewHeight.isActive = false
        
    }
    
    override func viewWillLayoutSubviews() {
        csViewHeight.isActive = true
    }

    
    // SOURCE: https://stackoverflow.com/questions/28604429/how-to-open-maps-app-programmatically-with-coordinates-in-swift
    func openMapForPlace() {
        
        if let garage = garage {
            let lat1 : NSString = String(garage.latitude ?? 0) as NSString
            let lng1 : NSString = String(garage.longitude ?? 0) as NSString

            let latitude:CLLocationDegrees =  lat1.doubleValue
            let longitude:CLLocationDegrees =  lng1.doubleValue

            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "\(garage.name ?? "")"
            mapItem.openInMaps(launchOptions: options)

        }

       
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            niName.title = garage.name
            lblTitle.text = garage.name
            lblDescription.text = garage.description
            
            let initialLocation = CLLocation(latitude: garage.latitude!, longitude: garage.longitude!)
            let geocoder: CLGeocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(initialLocation, completionHandler: {
                        placemarks, error in

                if error == nil && placemarks!.count > 0 {
                    let placeMark = placemarks!.last
                    
                    let locationString = "\(placeMark!.thoroughfare ?? ""), \(placeMark!.postalCode ?? "") \(placeMark!.locality ?? ""), \(placeMark!.country ?? "")"
                    
                    self.lblAddress.text = locationString
                    
                    let name = "\(garage.name ?? "")"
                
                    self.mvLocation.centerToLocation(initialLocation)
                    self.addAnnotationToMap(name: name, latitude: garage.latitude!, longitude: garage.longitude!)
                }
            })
        }
    }
    
    func createUI() {
        btBook.layer.cornerRadius = 10
        btBook.layer.borderWidth = 0.5
        btBook.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func addAnnotationToMap(name: String, latitude: Double, longitude: Double) {
        let garage = MKPointAnnotation()
        garage.title = name
        garage.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mvLocation.addAnnotation(garage)
    }
    
    func getLocationString(latitude: Double, longitude: Double) -> String  {
        let location: CLLocation = CLLocation(latitude:latitude, longitude: longitude)
        let geocoder: CLGeocoder = CLGeocoder()
        
        var locationString: String = ""
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {
                    placemarks, error in

            if error == nil && placemarks!.count > 0 {
                let placeMark = placemarks!.last
                
                locationString = "\(placeMark!.thoroughfare ?? ""), \(placeMark!.postalCode ?? "") \(placeMark!.locality ?? ""), \(placeMark!.country ?? "")"
            }
        })
        
        print("locationString" + locationString)
        return locationString
    }
    
    private func addGarageToHistory() {
        if let garage = garage {
            var history = garageModelController.loadHistoryFromFile()
            
            if history != nil {
                
                if let index = history!.firstIndex(of: garage) {
                    history!.remove(at: index)
                }
                
                history!.insert(garage, at: 0)
                if history!.count > 5 {
                    let slice = history![0...5]
                    history = Array(slice)
                }
                
                
            }
            
            garageModelController.saveHistoryToFile(history!)
        }
    }
    
    private func updateHeart() {
        if ((garage?.favorite) != nil) && garage?.favorite == true {
            heartGarage.image = UIImage(systemName: "heart.fill")
        } else {
            heartGarage.image = UIImage(systemName: "heart")
        }
    }
}


// SOURCE: https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 20000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

