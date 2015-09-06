//
//  AccelerometerQuery.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 06/09/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit

class AccelerometerQuery: VectorFn{
    
    //var List : Array<SensorUploadSensorData>
    
    // have to pass object of type G along with timestamps
    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
        
        let vm = NervousVM.sharedInstance
        //dummy object
        super.init()
        //dummy retreive
        //self.List = vm.retrieve(0x0000000000000000, fromTimeStamp: 0, toTimeStamp: 0)
        //actual retreive
        self.List = vm.retrieve(0x0000000000000000, fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
        
        /*if(containsReading()){
        NSLog("this is the variable value: %d")
        }*/
    }
    
    func getSensorID() -> UInt64{
        return 0x0000000000000000
    }
    
    func getCount() -> Int
    {
        return List.count
    }
    
    func containsReading() -> Bool{
        
        if(List.count == 0)  //check for null equivalent
        {return false}
        else
        {return true}
    }
    
    override func createSensorDescVectorValue(sensorData : SensorUploadSensorData) -> SensorDescVectorValue{
        var m = SensorDescAccelerometer( sensorData : sensorData )
        return m
    }
    
    func getSensorDescriptorList() -> Array<SensorDescVectorValue>{
        var descList = Array<SensorDescVectorValue>()
        for sensorData in List {
            descList.append(createSensorDescVectorValue(sensorData))
            
        }
        return descList
    }
    
    override func createDummyObject()-> SensorDescVectorValue{
        var m = SensorDescAccelerometer(timestamp: 0, accX: 0, accY: 0, accZ: 0)
        return m
    }
    
    /*func getMaxValue()-> SensorDescAccelerometer{
        var maxSensDesc = createDummyObject()
        var maxVal = FLT_MIN
        
        for sensorData in List{
            var sensDesc = createSensorDescVectorValue(sensorData)
            var temp = sensDesc.getValue()
            var f :Float = 0
            for var i = 0;i < temp.count;++i{
                f += temp[i]
            }
            if(f > maxVal){
                maxVal = f
                maxSensDesc = sensDesc
            }
        }
        
        return maxSensDesc
    }*/
   
}
