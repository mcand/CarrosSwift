//
//  MapViewController.swift
//  Carros
//
//  Created by Andre Furquin on 1/1/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var locManager = CLLocationManager()
    var carro: Carro?
    @IBOutlet var mapView: MKMapView!
    var pin = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.requestWhenInUseAuthorization()
        if (carro != nil) {
            // latitude e longitude
            var lat = (self.carro!.latitude as NSString).doubleValue
            var lng = (self.carro!.longitude as NSString).doubleValue
            // Coordenada latitude e longitude
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location = MKCoordinateRegion(center: center, span: span)
            // centraliza o mapa nesta coordenada
            self.mapView.setRegion(location, animated: true)
            self.mapView.mapType = MKMapType.Satellite
            
            pin.coordinate = location.center
            pin.title = "Fábrica \(self.carro!.nome)"
            self.mapView.addAnnotation(pin)
            
            // Delegate
            self.mapView.delegate = self
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        pinView.pinColor = MKPinAnnotationColor.Red
        pinView.canShowCallout = true
        let btPin = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIView
        pinView.rightCalloutAccessoryView = btPin
        return pinView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        Alerta.alert("Opa!", viewController: self, nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
