//
//  ResultCell.swift
//  Swig
//
//  Created by Philip Canniff on 4/8/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var inviteButton: UIButton!
   
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var uberButton: UIButton!
    
    @IBOutlet weak var resultTitle: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //UPDATE BUTTON UI WITH BORDERS
        placeImage.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).CGColor
        placeImage.layer.borderWidth = 1.0;
        
        inviteButton.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).CGColor
        inviteButton.layer.borderWidth = 1.0;
        
        callButton.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).CGColor
        callButton.layer.borderWidth = 1.0;
        
        uberButton.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).CGColor
        uberButton.layer.borderWidth = 1.0;
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
