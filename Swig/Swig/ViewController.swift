//
//  ViewController.swift
//  Swig
//
//  Created by Philip Canniff on 4/5/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    let locManager = CLLocationManager()
    
    var requestFiler = "restaurant"
    
    var requestRange = "1500"

    @IBOutlet weak var typeView: UICollectionView!
    
    @IBOutlet weak var rangeView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Place Manager Types
        PlaceManager.sharedInstance.buildPlaceTypes()
        
        //Request Location Authorization When App In Use
        locManager.requestWhenInUseAuthorization()
        
        //Notification Center Registration
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.segueToResult), name: "com.ponderMobile.Swig.Result", object: nil)
        
        //Nib Registers
        typeView.registerNib(UINib(nibName: "pickerCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeReuse")
        rangeView.registerNib(UINib(nibName: "pickerCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeReuse")
        
        //Navigation Bar Setup
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("SWIG", comment: "");
        
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.8, green: 1.0, blue: 0.6, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Organize, target: self, action: #selector(ViewController.segueFavorites)), animated: true)
       
        
    }
    
    //MARK: ACTIONS
    
    /*Action will open a Google Place Picker view*/
//    @IBAction func pickerAction(sender: AnyObject) {
//        
//        let acController = GMSAutocompleteViewController()
//        
//        acController.delegate = self
//        
//        self.presentViewController(acController, animated: true, completion: nil)
//        
//    }

    /*Action will request Places from Google Places Web API Services */
    @IBAction func searchAction(sender: UIButton) {
        
        PlaceManager.sharedInstance.requestPlaces("\(locManager.location!.coordinate.longitude)", lat: "\(locManager.location!.coordinate.latitude)", typeFiler: requestFiler, range: requestRange)
    
    }
    
    func segueFavorites(){
    
    /*Code will eventually segue to ResultController with user favorites shown*/
    
    }
    
    func segueToResult(){
        
        print(PlaceManager.sharedInstance.places.count)
    
        performSegueWithIdentifier("resultSegue", sender: self)
    
    }
    
    //MARK: COLLECTION VIEW CODE

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1;
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return PlaceManager.sharedInstance.placeTypes.count
        } else {
            return 4
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("typeReuse", forIndexPath: indexPath) as! pickerCellCollectionViewCell
        
        if collectionView.tag == 0 {
        /*Type Collection Setup*/
            
            cell.pickerImage.image = PlaceManager.sharedInstance.placeTypes[indexPath.row].icon
            cell.pickerTitle.text = PlaceManager.sharedInstance.placeTypes[indexPath.row].name
            
            return cell
            
        
        } else if collectionView.tag == 1 {
        /*Range Collection Setup*/
        
            cell.pickerImage.image = PlaceManager.sharedInstance.placeTypes[indexPath.row].icon
            
            return cell
        }
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    
    //MARK: LOCATION DELEGATE METHOD
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate = manager.location?.coordinate
        
        print(coordinate!.longitude)
        print(coordinate!.latitude)
        
        //        long = "\(coordinate!.longitude)"
        //        lat = "\(coordinate!.latitude)"
        
        locManager.stopUpdatingLocation()
        
    }
    
    //MARK: PLACE PICKER DELEGATE METHODS
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
        
        // TODO: handle the error.
        print("Error: \(error.description)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func wasCancelled(viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}