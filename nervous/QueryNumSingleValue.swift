//
//  QueryNumSingleValue.swift
//  nervousnet
//
//  Created by Ramapriya Sridharan on 21/05/2015.
//  Copyright (c) 2015 ethz. All rights reserved.
//

import UIKit
import Foundation
import Darwin

//query,querynum and querynumsinglevalue together

 class QueryNumSingleValue<G : SensorDescSingleValue> {
    
    
    var List : Array<SensorUploadSensorData>
    
    func getSensorId() -> UInt64{
        fatalError("Must Override")
    }
    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
        let vm = NervousVM()
        
        self.List = vm.retrieve(0, fromTimeStamp: 0, toTimeStamp: 0)
        self.List = vm.retrieve(getSensorId(), fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
        if(containsReading()){
            println("retreived list of size /(getCount())")
        }
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
    
    func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> G{
        fatalError("Must Override")
    }
    
    func getSensorDescriptorList() -> Array<G>{
        var descList = Array<G>()
        for sensorData in List {
            descList.append(createSensorDescSingleValue(sensorData))
            
        }
        return descList
    }
    
    func createDummyObject()-> G{
        fatalError("Must Override")
    }
    
    func getTimeRange(desc_list : Array<G>, s : Array<Float>, e : Array<Float>)-> Array<G>{
        var start = s[0]
        var end = e[0]
        
        var answer = Array<G>()
        
        for var i=0; i<desc_list.count ; ++i{
            
            let sensDesc = desc_list[i]
            if(sensDesc.getValue() <= end && sensDesc.getValue() >= start)
            {
                answer.append(sensDesc)
            }
        }
        
        return answer
        
    }
    
    func getMaxValue()-> G{
        var maxSensDesc = createDummyObject()
        var maxVal = FLT_MIN
        
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            if(sensDesc.getValue() > maxVal){
                maxVal = sensDesc.getValue()
                maxSensDesc = sensDesc
            }
        }
        
       return maxSensDesc
    }
    
    func getMinValue()-> G{
        var minSensDesc = createDummyObject()
        var minVal = FLT_MAX
        
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            if(sensDesc.getValue() < minVal){
                minVal = sensDesc.getValue()
                minSensDesc = sensDesc
            }
        }
        
        return minSensDesc
    }
    
    func getAverage()-> Array<Float>{
        var temp = Array<Float>()
        var totalSum : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()
            
        }
        var average = totalSum/Float(List.count)
        temp.append(average)
        return temp
    }
    
    func sd()-> Array<Float>{
        var sd = Array<Float>()
        var temp = variance()
        var t = temp[0]
        t = sqrt(t)
        sd.append(t)
        return sd
    }
    
    
    func variance()-> Array<Float>{
        var sd = Array<Float>()
        var av = getAverage()
        var average = av[0]
        var temp : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            temp += (average - sensDesc.getValue())*(average - sensDesc.getValue())
        }
        temp = temp/Float(List.count)
        sd.append(temp)
        return sd
    }
    
    func getRms()->Array<Float>{
        var temp = Array<Float>()
        var totalSum :Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()*sensDesc.getValue()
            
        }
        var average = totalSum/Float(List.count)
        average = sqrt(average)
        temp.append(average)
        return temp
        
    }
    
    func getMeanSquare()->Array<Float>{
        var temp = Array<Float>()
        var totalSum : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()*sensDesc.getValue()
            
        }
        var average = totalSum/Float(List.count)
        temp.append(average)
        return temp
    }
    
    func getSum()->Array<Float>{
        var temp = Array<Float>()
        var totalSum : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()
            
        }
        
        temp.append(totalSum)
        return temp
        
    }
    
    func getSumSquare()->Array<Float>{
        var temp = Array<Float>()
        var totalSum : Float = 0
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensDesc.getValue()*sensDesc.getValue()
            
        }
        
        temp.append(totalSum)
        return temp
        
    }
    
    func getRmsError(comp : Array<Float>)-> Array<Float>{
        var answer = Array<Float>()
        var temp : Float = 0
        var data = comp[0] //only 1 value
        for sensorData in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            temp += powf(sensDesc.getValue()-data, 2)
        }
        temp = sqrt(temp/Float(List.count))
        answer.append(temp)
        return answer
    }
    
    func getMedian()-> Array<Float>{
        var temp = Array<Float>()
        var desc_list = Array<G>()
        for sensorData in List{
            desc_list.append(createSensorDescSingleValue(sensorData))
            
        }
        var middle : Float
        if(List.count%2 == 0){
            middle = desc_list[List.count/2].getValue()
        }
        else
        {middle = desc_list[List.count/2].getValue() + desc_list[List.count/2+1].getValue()}
        
        
        temp.append(middle)
        return temp
    }
    
    func compare(obj1 : G,obj2:G)->Bool{
        //if return 0 first larger than second
        //else 1
        if(obj1.getValue() >= obj2.getValue()){
            return false
        }
        if(obj1.getValue() > obj2.getValue()){
            return true
        }
        return false
    }
    
    

}

