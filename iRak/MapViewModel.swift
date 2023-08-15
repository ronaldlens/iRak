//
//  MapViewModel.swift
//  iRak
//
//  Created by Ronald Lens on 15/08/2023.
//

import MapKit
import Observation

@Observable class MapViewModel:NSObject, CLLocationManagerDelegate {
    var reachData = ReachData()
    var showBouys = true
    var showReaches = true
    
    static let shared = MapViewModel()
    
}
