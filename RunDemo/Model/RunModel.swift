//
//  RunModel.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/13.
//

import UIKit
import CoreLocation

class RunModel: NSObject {
    var speed: Int
    var distance: Int
    var time: Int
//    var location: [CLLocation]
    
    init(_ speed: Int,_ distance: Int,_ time: Int) {
        self.speed = speed
        self.distance = distance
        self.time = time
    }
}
