//
//  ADFWMapTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import UIKit
import MapKit

class ADFWMapTableViewCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var mapKit: MKMapView!
    
    
    var calloutView: CustomCalloutView?
    var locations: [Locations] = []
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapKit.delegate = self
        mapKit.showsUserLocation = true
        mapKit.isScrollEnabled = false
            mapKit.isZoomEnabled = false
            mapKit.isRotateEnabled = false
            mapKit.isPitchEnabled = false      
            mapKit.isUserInteractionEnabled = false
        titleLabel.setStyledTextWithLastWordColor(fullText: "ADFW Map", lastWordColor: .blueColor)
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func zoomToFitAllAnnotations() {
    mapKit.showAnnotations(mapKit.annotations, animated: true)
    }
    
    // MARK: - Map Helpers
    
    func addLocationPins(from venues: [Locations]) {
        mapKit.removeAnnotations(mapKit.annotations)
        for location in venues {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotation.subtitle = location.subtitle
            mapKit.addAnnotation(annotation)
        }
    }
    
    func configureMap() {
        self.addLocationPins(from: locations)
        self.zoomToFitAllAnnotations()
    }
    
    @IBAction func viewAllButtonAction(_ sender: Any) {
        
        
    }
    
    

    
    
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        calloutView?.removeFromSuperview()
        
        guard let title = annotation.title ?? "",
              let location = locations.first(where: { $0.name == title }) else { return }
        
        let callout = CustomCalloutView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        callout.configure(with: location.name, subtitle: location.subtitle, image: location.imageName)
        
        callout.center = CGPoint(x: view.bounds.size.width / 2, y: -callout.bounds.size.height / 2)
        view.addSubview(callout)
        calloutView = callout
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        calloutView?.removeFromSuperview()
    }
}
