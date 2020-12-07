//
//  GarageShowMapViewController.swift
//  ParkValley
//
//  Created by Robbe on 07/12/2020.
//

import UIKit
import MapKit

class GarageShowMapViewController: UIViewController {
    
    @IBOutlet var mvMap: MKMapView!
    var garage: Garage?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            
            let initialLocation = CLLocation(latitude: garage.latitude!, longitude: garage.longitude!)
            mvMap.centerToLocation(initialLocation)
            
            addAnnotationToMap(name: garage.name!, latitude: garage.latitude!, longitude: garage.longitude!)
        }
    }
    
    
    func addAnnotationToMap(name: String, latitude: Double, longitude: Double) {
        let garage = MKPointAnnotation()
        garage.title = name
        garage.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mvMap.addAnnotation(garage)
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

