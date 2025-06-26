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
    let imageName: String 
}

// MARK: - ViewController
class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var mapkit: MKMapView!

    var calloutView: CustomCalloutView?
    var locations: [Locations] = []
    var viewModel = VenueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapkit.delegate = self
        mapkit.showsUserLocation = true

      
        zoomToFitAllAnnotations()
        fetchVenueData()
        
        pageTitle.font = FontManager.font(weight: .semiBold, size: 19)
    }

    // MARK: - Add Annotations
    
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
