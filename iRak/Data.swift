//
//  Data.swift
//  iRak
//
//  Created by Ronald Lens on 12/08/2023.
//

import SwiftUI
import MapKit

struct BoeiSrc : Codable {
    let nr: Int
    let naam: String
    let lat: Double
    let lon: Double
    let kleur: String?
    let licht: String?
}

struct Boei: Identifiable, Hashable {
    static func == (lhs: Boei, rhs: Boei) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var naam: String
    var kleur: String
    var licht: String
    var location: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct RakSrc: Codable {
    let nr: Int
    let van : String
    let naar: String
}

struct Rak: Identifiable, Hashable {
    static func == (lhs: Rak, rhs: Rak) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    var from: CLLocationCoordinate2D
    var to: CLLocationCoordinate2D
    var times: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


class ReadData {
    var boeien: [Boei] = []
    var rakken: [Rak] = []
    
    init() {
        loadBoeienEnRakken()
    }
    
    func loadBoeienEnRakken() {
        var boeienSrc: [BoeiSrc]
        var rakkenSrc: [RakSrc]
        
        guard let url = Bundle.main.url(forResource: "boeien", withExtension: "json")
        else {
            print("boeien.json not found")
            return
        }
        let boeiData = try? Data(contentsOf: url)
        do {
            boeienSrc = try JSONDecoder().decode([BoeiSrc].self, from: boeiData!)
            addBoeiLocations(src: boeienSrc)
        } catch {
            print("error \(error)")
        }
        guard let url = Bundle.main.url(forResource: "rakken", withExtension: "json")
        else {
            print("rakken.json not found")
            return
        }
        let rakData = try? Data(contentsOf: url)
        do {
            let rakkenSrc = try JSONDecoder().decode([RakSrc].self, from: rakData!)
            addRakkenLocations(src: rakkenSrc)
            
        } catch {
            print("error \(error)")
        }
        print("loaded boeien en rakken")
    }
 
    func addBoeiLocations(src: [BoeiSrc]) {
        for boeiSrc in src {
            let id = boeiSrc.nr
            let naam = boeiSrc.naam
            let kleur = boeiSrc.kleur ?? ""
            let licht = boeiSrc.licht ?? ""
            let location = CLLocationCoordinate2D(latitude: boeiSrc.lat, longitude: boeiSrc.lon)
            let boei = Boei(id: id, naam: naam, kleur: kleur, licht: licht, location: location)
            boeien.append(boei)
        }
    }
    
    func addRakkenLocations(src: [RakSrc]) {
        
    }
}
