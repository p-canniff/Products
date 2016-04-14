//
//  MapViewController.swift
//  Swig
//
//  Created by Philip Canniff on 4/8/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    let locManager = CLLocationManager()
    
    @IBOutlet weak var placeTitle: UILabel!
    
    @IBOutlet weak var placeNumber: UILabel!
    
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var placeDesc: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var carButton: UIButton!
    
    @IBOutlet weak var inviteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64), styleURL: NSURL(string:"mapbox://styles/pondermobile/cimt9oodi004cp1nh7qw58bee"))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.8, green: 1.0, blue: 0.6, alpha: 1.0)
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
//        placeImage.clipsToBounds = true
//        placeImage.layer.cornerRadius = (placeImage.layer.frame.height/2)
//        placeImage.layer.borderColor = UIColor.whiteColor().CGColor
//        placeImage.layer.borderWidth = 2.0;
        
        callButton.layer.cornerRadius = (callButton.layer.frame.height/2)
        callButton.layer.borderColor = UIColor.whiteColor().CGColor
        callButton.layer.borderWidth = 2.0;
        callButton.tintColor = UIColor.whiteColor()
        
        inviteButton.layer.cornerRadius = (callButton.layer.frame.height/2)
        inviteButton.layer.borderColor = UIColor.whiteColor().CGColor
        inviteButton.layer.borderWidth = 2.0;
        
        carButton.clipsToBounds = true
        carButton.layer.cornerRadius = (carButton.layer.frame.height/2)
        carButton.layer.borderColor = UIColor.whiteColor().CGColor
        carButton.layer.borderWidth = 2.0;
        
        
        //Re-adding views to layer ontop of the mapView.
        self.view.addSubview(mapView)
        self.view.addSubview(placeImage)
        self.view.addSubview(callButton)
        self.view.addSubview(carButton)
        self.view.addSubview(inviteButton)
        self.view.addSubview(placeTitle)
        self.view.addSubview(placeNumber)
        self.view.addSubview(placeDesc)
        
    }

    func mapViewDidFinishLoadingMap(mapView: MGLMapView) {
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: (locManager.location?.coordinate.latitude)!, longitude: (locManager.location?.coordinate.longitude)!), zoomLevel: 14, animated: true)
    }


}
