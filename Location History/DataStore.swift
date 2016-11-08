//
//  DataStore.swift
//  Location History
//
//  Created by hostname on 10/20/16.
//  Copyright © 2016 notungood. All rights reserved.
//

import Foundation

struct StorageKeys {
    static let storedLat = "storedLat"
    static let storedLong = "storedLong"
}

class DataStore {
    
    func getDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func storeDataPoint(latitude: String, longitude: String) {
        let def = getDefaults()
        
        def.setValue(latitude, forKeyPath: StorageKeys.storedLat)
        def.setValue(longitude, forKeyPath: StorageKeys.storedLong)
        
        def.synchronize()
        
        print(latitude + " : " + longitude)
    }
    
    func getLastLocation() -> VisitedPoint? {
        let def = getDefaults()
        
        if let lat = def.string(forKey: StorageKeys.storedLat) {
            if let long = def.string(forKey: StorageKeys.storedLong) {
                return VisitedPoint(lat: lat, long: long)
            }
        }
        
        return nil
    }
    
}
