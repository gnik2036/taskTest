//
//  ViewController.swift
//  taskIOTBLUE
//
//  Created by shady on 9/10/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class Map: UIViewController , UIGestureRecognizerDelegate {
  
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    var locationManger = CLLocationManager()
    let authorization = CLLocationManager.authorizationStatus()
    let regionRedious :Double = 1000
    var locationsContainer = [String]()
    var lat:String?
    var lon:String?
    var container :String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        locationManger.delegate = self
        print ("we are here AuthorizationDouble tap")
        checkAuthorization()
         print ("we are here Double tap")
        addDoubleTap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addDoubleTap()
    {
        print ("we are here ")
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView	.addGestureRecognizer(doubleTap)
        
    }
    @IBAction func locationOnMap(_ sender: Any) {
        if  authorization == .authorizedAlways || authorization == .authorizedWhenInUse
        {
            centerUserOnLocation()
        }
    }
    @IBAction func weatherButton(_ sender: Any) {
        
        performSegue(withIdentifier:"goToSecondScreen", sender: self)
        print (locationsContainer)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen"
        {
            let bookMark = segue.destination as! BookMarks
            bookMark.locationsContainer = locationsContainer
            
        }
    }
}
extension Map : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
        return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
        
    }
    func centerUserOnLocation()
    {
        
     guard let coordinate = locationManger.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRedious * 2.0, regionRedious * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    @objc func dropPin(sender : UITapGestureRecognizer)   {
        removerDropPin()
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        var annonation = droppedPin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annonation)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRedious * 2.0, regionRedious * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        ////////////////////////////////////////
        lat = String(touchCoordinate.latitude)
        lon = String(touchCoordinate.longitude)
        container = lat! + "*" + lon!
        locationsContainer.append(container!)
        print (touchCoordinate)
        
    }
    func removerDropPin() {
        for annotation in mapView.annotations
        {
            mapView.removeAnnotation(annotation)
        }
    }
}
extension Map : CLLocationManagerDelegate
{
    func checkAuthorization ()
    {
        if authorization == .notDetermined
        {
            locationManger.requestAlwaysAuthorization()
        }
        else {
            return
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerUserOnLocation()
    }
    
}















