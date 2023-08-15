//
//  Data.swift
//  iRak
//
//  Created by Ronald Lens on 12/08/2023.
//

import SwiftUI
import MapKit

struct BouySrc : Codable {
    let nr: Int
    let naam: String
    let lat: Double
    let lon: Double
    let kleur: String?
    let licht: String?
}

struct Bouy: Identifiable, Hashable {
    static func == (lhs: Bouy, rhs: Bouy) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var color: String
    var light: String
    var location: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ReachSrc: Codable {
    let nr: Int
    let van : String
    let naar: String
}

struct Reach: Identifiable, Hashable {
    static func == (lhs: Reach, rhs: Reach) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    var coords: [CLLocationCoordinate2D]
    var times: Int
    let heading: Int
    let distance: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


class ReachData {
    var bouys: [Bouy] = []
    var reaches: [Reach] = []
    
    static let instance = ReachData()
    
    init() {
        loadBouysAndReaches()
    }
    
    func loadBouysAndReaches() {
        guard let url = Bundle.main.url(forResource: "boeien", withExtension: "json")
        else {
            print("boeien.json not found")
            return
        }
        let bouyData = try? Data(contentsOf: url)
        do {
            let bouySrc = try JSONDecoder().decode([BouySrc].self, from: bouyData!)
            addBoeyLocations(src: bouySrc)
        } catch {
            print("error \(error)")
        }
        guard let url = Bundle.main.url(forResource: "rakken", withExtension: "json")
        else {
            print("rakken.json not found")
            return
        }
        let reachData = try? Data(contentsOf: url)
        do {
            let rakkenSrc = try JSONDecoder().decode([ReachSrc].self, from: reachData!)
            addReachLocations(src: rakkenSrc)
            
        } catch {
            print("error \(error)")
        }
        print("loaded boeien en rakken")
    }
 
    func addBoeyLocations(src: [BouySrc]) {
        for boeiSrc in src {
            let id = boeiSrc.nr
            let name = boeiSrc.naam
            let color = boeiSrc.kleur ?? ""
            let light = boeiSrc.licht ?? ""
            let location = CLLocationCoordinate2D(latitude: boeiSrc.lat, longitude: boeiSrc.lon)
            let bouy = Bouy(id: id, name: name, color: color, light: light, location: location)
            bouys.append(bouy)
        }
    }
    
    func addReachLocations(src: [ReachSrc]) {
        for rakSrc in src {
            let id = rakSrc.nr
            let bouyFrom = findBouy(name: rakSrc.van)
            let bouyTo = findBouy(name: rakSrc.naar)
            let locationFrom = bouyFrom.location
            let locationTo = bouyTo.location
            let bearing = locationFrom.bearing(to: locationTo)
            let distance = locationFrom.distance(to: locationTo)
            let reach = Reach(id: id, coords: [locationFrom, locationTo], times: 2, heading: bearing, distance: distance)
            reaches.append(reach)
        }
    }
    
    func findBouy(name: String) -> Bouy {
        for bouy in bouys {
            if name == bouy.name {
                return bouy
            }
        }
        print("boey \(name) not found")
        return bouys[0]
    }
}

extension CLLocationCoordinate2D {
    func bearing(to point: CLLocationCoordinate2D) -> Int {
        func degreesToRadians(_ degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
        func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / Double.pi }
        
        let lat1 = degreesToRadians(latitude)
        let lon1 = degreesToRadians(longitude)
        
        let lat2 = degreesToRadians(point.latitude);
        let lon2 = degreesToRadians(point.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return Int(radiansToDegrees(radiansBearing))
    }
    
    func distance(to: CLLocationCoordinate2D) -> Double {
        MKMapPoint(self).distance(to: MKMapPoint(to)) * 0.000539956803
    }
}
