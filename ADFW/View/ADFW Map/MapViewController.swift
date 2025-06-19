//
//  MapViewController.swift
//  ADFW
//
//  Created by MultiTV on 04/06/25.
//

import UIKit
import MapKit

// MARK: - Model
struct Locations {
    let name: String
    let subtitle: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let imageName: String // Image name in your asset catalog
}

// MARK: - ViewController
class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var mapkit: MKMapView!

    var calloutView: CustomCalloutView?
    var locations: [Locations] = []
    var viewModel = VenueViewModel()

    // Sample Locations
//    let locations: [Location] = [
//        Location(name: "Four Seasons Hotel", subtitle: "View more details", latitude: 25.1972, longitude: 55.2744, imageName: "hotel"),
//        Location(name: "Capital Square", subtitle: "View more details", latitude: 25.2048, longitude: 55.2708, imageName: "square"),
//        Location(name: "Falcon Square", subtitle: "View more details", latitude: 25.2100, longitude: 55.2775, imageName: "falcon"),
//        Location(name: "Inside ADGM", subtitle: "View more details", latitude: 25.2133, longitude: 55.2810, imageName: "adgm"),
//        Location(name: "Rosewood Hotel", subtitle: "Luxury stay in Al Maryah", latitude: 25.2105, longitude: 55.2819, imageName: "rosewood"),
//        Location(name: "Jumeirah at Etihad Towers", subtitle: "Modern 5-star hotel", latitude: 25.2022, longitude: 55.2702, imageName: "etihad"),
//        Location(name: "St. Regis Abu Dhabi", subtitle: "Opulent city views", latitude: 25.2111, longitude: 55.2793, imageName: "stregis"),
//        Location(name: "The Ritz-Carlton", subtitle: "Waterfront luxury", latitude: 25.2083, longitude: 55.2750, imageName: "ritzcarlton")
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        mapkit.delegate = self
        mapkit.showsUserLocation = true

      
        zoomToFitAllAnnotations()
        fetchVenueData()
        
        pageTitle.font = FontManager.font(weight: .semiBold, size: 19)
    }

    // MARK: - Add Annotations
    func addLocationPins() {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotation.subtitle = location.subtitle
            mapkit.addAnnotation(annotation)
        }
    }
    
    
    func addLocationPins(from venues: [Locations]) {
        self.locations = venues // Make `locations` a var instead of let
        for location in venues {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotation.subtitle = location.subtitle
            mapkit.addAnnotation(annotation)
        }
    }

    // MARK: - Zoom to Fit All
    func zoomToFitAllAnnotations() {
        mapkit.showAnnotations(mapkit.annotations, animated: true)
    }

    // MARK: - Custom Pin View
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }

        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.image = UIImage(named: "pin")
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    // MARK: - Show Custom View on Tap
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        // Remove existing custom view
        calloutView?.removeFromSuperview()

        guard let title = annotation.title ?? "",
              let location = locations.first(where: { $0.name == title }) else { return }

        let callout = CustomCalloutView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        //let image = UIImage(named: location.imageName)
        callout.configure(with: location.name, subtitle: location.subtitle, image: location.imageName)

        // Position above the pin
        callout.center = CGPoint(x: view.bounds.size.width / 2, y: -callout.bounds.size.height / 2)
        view.addSubview(callout)
        calloutView = callout
    }

    // MARK: - Remove View When Unselected
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        calloutView?.removeFromSuperview()
    }

    // MARK: - Back Action
    @IBAction func bacKAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension MapViewController {
    
    
    func fetchVenueData() {
        viewModel.fetchVenueData(in: self.view) { result in
            
            switch result {
            case .success(let success):
                self.locations = success
                self.addLocationPins(from: success)
                self.zoomToFitAllAnnotations()
            case .failure(let failure):
                MessageHelper.showBanner(message: failure.localizedDescription, status: .error)
            }
            
            
        }
    }

}
