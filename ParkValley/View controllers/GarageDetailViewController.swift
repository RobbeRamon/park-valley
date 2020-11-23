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
    @IBOutlet var mvMap: MKMapView!
    
    var garage: Garage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            niName.title = garage.name
            
            let initialLocation = CLLocation(latitude: garage.latitude!, longitude: garage.longitude!)
            mvMap.centerToLocation(initialLocation)
            
//            let oahuCenter = CLLocation(latitude: garage.latitude!, longitude: garage.longitude!)
//            let region = MKCoordinateRegion(
//              center: oahuCenter.coordinate,
//              latitudinalMeters: 50000,
//              longitudinalMeters: 60000)
//            mvMap.setCameraBoundary(
//              MKMapView.CameraBoundary(coordinateRegion: region),
//              animated: true)
//            
//            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
//            mvMap.setCameraZoomRange(zoomRange, animated: true)
            
            addAnnotationToMap(name: garage.name!, latitude: garage.latitude!, longitude: garage.longitude!)
        }
    }
    
    // MARK: - Helper methods
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
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
