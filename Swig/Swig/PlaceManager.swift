//
//  PlaceManager.swift
//  Swig
//
//  Created by Philip Canniff on 4/9/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

class PlaceManager : NSObject {
    
    static let sharedInstance = PlaceManager();
    private override init() {}

    var placeLocManager = CLLocationManager()
    var myData = NSMutableData()
    var error : NSError!
    var request : NSMutableURLRequest!
    
    var ids : [String] = []
    var places : [Place] = []
    var placeTypes : [PlaceType] = []
    let placeRanges : [String] = ["8000", "16000", "25000", "32000", "40000"]
    let rangeIDs : [String] = ["5m","10m","15m","20m", "25m"]
    
    func buildPlaceTypes(){
    
        let food = PlaceType(name: "Food", filter: "restaurant", image: UIImage(named:"place_food_image")!, icon: UIImage(named: "rest_icon")!)
        let drinks = PlaceType(name: "Drinks", filter: "bar", image: UIImage(named:"place_drinks_image")!, icon: UIImage(named: "bar_icon")!)
        let cafe = PlaceType(name: "Cafe", filter: "cafe", image: UIImage(named:"place_cafe_image")!, icon: UIImage(named: "cafe_icon")!)
        let movies = PlaceType(name: "Movies", filter: "restaurant", image: UIImage(named:"place_film_image")!, icon: UIImage(named: "film_icon")!)
        let health = PlaceType(name: "Health", filter: "bar", image: UIImage(named:"place_health_image")!, icon: UIImage(named: "heal_icon")!)
        let shops = PlaceType(name: "Shops", filter: "cafe", image: UIImage(named:"place_shop_image")!, icon: UIImage(named: "shop_icon")!)
        
        placeTypes.append(drinks)
        placeTypes.append(food)
        placeTypes.append(cafe)
        placeTypes.append(movies)
        placeTypes.append(health)
        placeTypes.append(shops)
    
    }
    
    //SUBMIT REQUEST FOR PLACES WITH PARAMETERS
    func requestPlaces(long : String, lat : String, typeFiler : String, range : String){
        
        let url = "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=\(lat),\(long)&radius=\(range)&type=\(typeFiler)&key=AIzaSyBSwhOT-ppzC2kG0HSdXzhTlb2beWLzwbA"
        print(url)
        
        let myUrl = NSURL(string: url);
        if let url = myUrl {
            request = NSMutableURLRequest(URL: url)
            httpGet(request);
        }
        
    }
    
    func requestDetails(placeID : String){
        
        

        let url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=AIzaSyBSwhOT-ppzC2kG0HSdXzhTlb2beWLzwbA"
        
        let myUrl = NSURL(string: url);
        if let url = myUrl {
            request = NSMutableURLRequest(URL: url)
            httpGetDetails(request);
        }
        
        
    }
    func httpGetDetails(request: NSURLRequest!) -> Void {
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
            
            if error != nil {
                print(error);
            } else {
                let json = data;
                self.myData = NSMutableData(data: json!);
                
                let queue = dispatch_queue_create("com.ponderMobile.Swig.Places", DISPATCH_QUEUE_CONCURRENT)
                dispatch_sync(queue, {
                    
                    if self.myData.length != 0 {
                        self.parseDetails()
                        self.myData.length = 0;
                    }
                })
                
            }
        }
        task.resume()
    }
    //HTTP GET REQUEST FOR GOOGLE API WEB SERVICES
    func httpGet(request: NSURLRequest!) -> Void {
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
            
            if error != nil {
                print(error);
            } else {
                let json = data;
                self.myData = NSMutableData(data: json!);
                
                let queue = dispatch_queue_create("com.ponderMobile.Swig.Places", DISPATCH_QUEUE_CONCURRENT)
                dispatch_sync(queue, {
                    
                    if self.myData.length != 0 {
                        self.parseJSON()
                        self.myData.length = 0;
                    }
                })
            }
        }
        task.resume()
    }

    //DIGGING INTO JSON RETURN AND GRABBING PLACE INFO
    func parseJSON() {
        print("PARSING WITH SWITFYJSON")
        
        ids = []
        places = []
        
        let response = JSON(data: myData);
        
        //print(response.description)
        
        if let children = response["results"].array {
            
            for child in children {
                
                let place_id = child["place_id"].string!
                
                ids.append(place_id)
                
            }
        }
        
        //print(ids.count)
        
        for id in ids {
            
            requestDetails(id)
            
        }
        
    }
    func parseDetails() {
        
        let response = JSON(data: myData);
        
        //print(response.description)
        
        if let result = response["result"].dictionary {
            
            
            let name = result["name"]!.string!
            let address = result["formatted_address"]!.string!
            //let phone = result["formatted_phone_number"]!.string!
            
            print(name)
            //let website = result["website"]!.string!
            
            let newResult = Place(name: name, phone: "", address: address)
            
            places.append(newResult)
            
            if ids.count == places.count {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("com.ponderMobile.Swig.Result", object: self)
                    
                })
            
            }
            
        }
        
    }

}