//
//  droppedPin.swift
//  taskIOTBLUE
//
//  Created by shady on 9/11/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import MapKit


class droppedPin : NSObject,MKAnnotation
{
   dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    init(coordinate: CLLocationCoordinate2D , identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super .init()
    }
}














