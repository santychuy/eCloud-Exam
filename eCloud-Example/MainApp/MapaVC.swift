//
//  MapaVC.swift
//  eCloud-Example
//
//  Created by Jesus Santiago Carrasco Campa on 7/25/19.
//  Copyright © 2019 Techson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelCoords: UILabel!
    
    let locationMan = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation()
        setupMap()
        
        guard let coords = mapView.userLocation.location?.coordinate else {return}
        mapView.setCenter(coords, animated: true)
        labelCoords.text = "Lat: \(coords.latitude) Lon: \(coords.longitude)"
    }
    
    private func setupLocation(){
        locationMan.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationMan.delegate = self
            locationMan.desiredAccuracy = kCLLocationAccuracyBest
            locationMan.startUpdatingLocation()
        }
    }
    
    private func setupMap(){
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
    }



}

extension MapaVC: CLLocationManagerDelegate, MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: false)
        
        mapView.setCenter(locValue, animated: true)
        labelCoords.text = "Lat: \(locValue.latitude) Lon: \(locValue.longitude)"
    }
}
