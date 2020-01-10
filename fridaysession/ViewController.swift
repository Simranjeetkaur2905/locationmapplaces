//
//  ViewController.swift
//  fridaysession
//
//  Created by Simran Chakkal on 2020-01-10.
//  Copyright © 2020 Simran Chakkal. All rights reserved.
//

import UIKit
import  MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView!
    var locationmanager = CLLocationManager()
    
    let places = Place.getPlaces()
    
    //for array of annotations we uses places
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addannotation()
        mapView.showsUserLocation = true
        
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
       // locationmanager.startUpdatingLocation()
        // Do any additional setup after loading the view.

    }
    
    func addannotation()  {
        mapView.delegate = self
        mapView.addAnnotations(places)
        
        let overlays = places.map{ (MKCircle(center: $0.coordinate, radius: 1000)) }
        mapView.addOverlays(overlays)
    }
}

extension ViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        else{
            let annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView ()
            annotationview.image = UIImage(named: "ic_place_2x")
            return annotationview
        }
    }
    
    
    //this func is needed to add overlays
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rendrer = MKCircleRenderer (overlay: overlay)
        rendrer.fillColor = UIColor.black.withAlphaComponent(0.5)
        rendrer.strokeColor = UIColor.green
        rendrer.lineWidth = 2
        return rendrer
    }
}

