//
//  SensorDescBLEBeacon.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation
import CoreLocation

class SensorDescBLEBeacon: SensorDesc {
    
    let SENSOR_ID :Int64 = 0x000000000000000B
    
    var timestamp :UInt64
    var rssi :Int32
    var mac :Int64
    var advertisementMSB :Int64
    var advertisementLSB :Int64
    var bleuuidMSB :Int64
    var bleuuidLSB :Int64
    var major :Int32
    var minor :Int32
    var txpower :Int32
    
    
    init(timestamp :UInt64, rssi :Int32, mac :Int64, advertisementMSB :Int64, advertisementLSB :Int64, bleuuidMSB :Int64, bleuuidLSB :Int64, major :Int32, minor :Int32, txpower :Int32){
        
        
        self.rssi = rssi
        self.mac = mac
        self.advertisementMSB = advertisementMSB
        self.advertisementLSB = advertisementLSB
        self.bleuuidMSB = bleuuidMSB
        self.bleuuidLSB = bleuuidLSB
        self.major = major
        self.minor = minor
        self.txpower = txpower
        self.timestamp = timestamp
        
        
    }
    
    init(beacon :CLBeacon, timestamp :UInt64){
      
        self.rssi = Int32(beacon.rssi)
        self.mac = 0
        self.advertisementMSB = 0
        self.advertisementLSB = 0
        self.bleuuidMSB = 0
        self.bleuuidLSB = 0
        self.major = Int32(beacon.major.integerValue)
        self.minor = Int32(beacon.minor.integerValue)
        self.txpower = -59
        self.timestamp = timestamp
    
    }
    

    
    func toProtoSensor() -> SensorUploadSensorData {
        
        let sdb = SensorUploadSensorData.builder()
        sdb.recordTime = self.timestamp
        sdb.valueInt64 = [self.mac, self.advertisementMSB, self.advertisementLSB, self.bleuuidMSB, self.bleuuidLSB]
        sdb.valueInt32 = [self.rssi, self.major, self.minor, self.txpower]
        
        return sdb.build()
    }


}