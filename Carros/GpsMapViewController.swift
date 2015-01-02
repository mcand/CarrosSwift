//
//  GpsMapViewController.swift
//  Carros
//
//  Created by Andre Furquin on 1/2/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import UIKit
import MapKit

class GpsMapViewController: MapViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicia o LocationManager para monitorar as coordenadas GPS
        self.locManager.delegate = self
        self.locManager.distanceFilter = 100.00
        self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        // Começa a monitorar o GPS
        self.locManager.startUpdatingLocation()
    }
    
    deinit{
        // Destrutor: desliga o monitoramento do GPS
        self.locManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // Última localização
        let newLocation = locations[locations.count-1] as CLLocation
        let lat = newLocation.coordinate.latitude
        let lng = newLocation.coordinate.longitude
        println("didUpdateLocaton lat\(lat), lng:\(lng)")
        // Coordenada (latitude/longitude)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        // Contraliza o mapa nessa cooderada
        self.mapView.setRegion(location, animated: true)
        // Atualiza o marcador para acompanhar o GPS
        self.pin.coordinate = center
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("locationManager.didFailWithError: \(error)")
    }
}
