//
//  ResultViewController.swift
//  Swig
//
//  Created by Philip Canniff on 4/7/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var resultView: UITableView!
    
    var resultPlaces : [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nib Registers
        resultView.registerNib(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultReuse")
        
        //Navigation Bar Setup
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem.init(image: UIImage(named: "place_icon"), style: .Plain, target: self, action: #selector(ResultViewController.mapSegue)), animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.8, green: 1.0, blue: 0.6, alpha: 1.0)

    }
    
    //Segue MapBox MapView
    func mapSegue(){
    
        performSegueWithIdentifier("mapSegue", sender: self)
    
    }
    
    //MARK: TableView Delegate Code
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceManager.sharedInstance.places.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultReuse") as! ResultCell
        
        cell.resultTitle.text = PlaceManager.sharedInstance.places[indexPath.row].name
        cell.addressLabel.text = PlaceManager.sharedInstance.places[indexPath.row].address
        
        //print(PlaceManager.sharedInstance.places.count)
        
        return cell
    }

}
