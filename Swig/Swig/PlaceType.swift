//
//  PlaceType.swift
//  Swig
//
//  Created by Philip Canniff on 4/9/16.
//  Copyright © 2016 Ponder Mobile. All rights reserved.
//

import Foundation
import UIKit

class PlaceType {

    var name : String
    var filter : String
    var image : UIImage
    var icon : UIImage


    init (name : String, filter : String, image : UIImage, icon : UIImage){
        
        self.name = name
        self.filter = filter
        self.image = image
        self.icon = icon
        
    }



}