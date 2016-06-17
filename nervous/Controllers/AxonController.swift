//
//  AxonController.swift
//  nervousnet-iOS
//  
//  Created by Sam Sulaimanov on 03 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//


import Foundation
import Swifter

///
/// Manages the Axon (HTTP and Socket) server and its routes. Asks for permission on
/// behalf of the Axons.
///
class AxonController {
    
    var server = HttpServer()
    
    let axonResourceDir = "\(NSBundle.mainBundle().resourcePath!)/Assets/axon-resources/"
    let axonDir = "\(NSHomeDirectory())/Documents/nervousnet-installed-axons/"
    let laeController = LAEController()

    init(){
        startAxonHTTPServer()
    }
	
    func startAxonHTTPServer(){
        
        do {
            try self.server.start()
            print("Server Started Successfully!")
            self.mapAxonHTTPServerRoutes()
        } catch {
            print("Server start error: \(error)")
        }

    }

    
    func restoreAxonHTTPServer(){
        self.startAxonHTTPServer()
    }
    
    
    func mapAxonHTTPServerRoutes(){
        
        // route to list available services
        self.server["/"] = { r in
            var listPage = "<div style='font-family: Helvetica; font-size: 12pt'>Available nervousnet services on this device:<br><ul>"
            for services in self.server.routes {
                if !services.isEmpty {
                    listPage += "<li><a href=\"\(services)\">\(services)</a></li>"
                }
            }
            listPage += "</ul></div>"
            return .OK(.Html(listPage))
        }
        
        
        // route to get static resources like JS, HTML or assets provided by nervous
        self.server.GET["/nervousnet-axon-resources/:resource"] = { r in
            if let filename = r.params[":resource"] {
                return self.returnRawResponse("\(self.axonResourceDir)\(filename)");
            }
            return .NotFound

        }
        
        // route to get any axon resource
        self.server.GET["/nervousnet-axons/:axonname/:resource"] = { r in
            if let filename = r.params[":resource"], axonname = r.params[":axonname"] {
                return self.returnRawResponse("\(self.axonDir)/\(axonname)/\(axonname)-master/\(filename)");
            }
            return .NotFound
        }

			// route to get any axon resource
			self.server.POST["/nervousnet-api/log"] = { r in
				print("axon debug:")
				print(String(bytes: r.body, encoding: NSUTF8StringEncoding))
				return .OK(.Json(""))
			}
			
			self.server.GET["/nervousnet-api/deviceid"] = { r in
				let uuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
				return .OK(.Json(["uuid": uuid]))
			}

        // route to get any axon resource
        self.server.GET["/nervousnet-api/raw-sensor-data/:sensor/"] = { r in
					
            if let sensor = r.params[":sensor"] {
							print(sensor)
							
                let data =  self.laeController.getData(sensor)
                
                print(data)
							
                if(sensor == "BLE"){
                    let jsonObject: NSDictionary = ["blepacket": data[0] as! String]
                    return .OK(.Json(jsonObject))
								}else if(sensor == "GPS"){
									let jsonObject: NSDictionary = ["lat": data[0], "long":data[1]]
									return .OK(.Json(jsonObject))
								}else if(sensor == "Beacon"){
									return .OK(.Json(data))
                }else{
                    let jsonObject: NSDictionary = ["x": data[0], "y":data[1], "z": data[2]]
                    return .OK(.Json(jsonObject))
                }
                
            }
            return .NotFound
        }
        
        
    }
    
    
    func returnRawResponse(fileURL:String) -> HttpResponse {
        
        if let contentsOfFile = NSData(contentsOfFile: fileURL) {
            print("getting \(fileURL)")

            var contentsOfFileBytes = [UInt8](count: contentsOfFile.length, repeatedValue: 0)
            contentsOfFile.getBytes(&contentsOfFileBytes, length: contentsOfFile.length)
            
            return HttpResponse.RAW(200, "OK", nil, { $0.write(contentsOfFileBytes) })
        }
        
        print("resource at \(fileURL) not found")
        return .NotFound
        
    }
    
    
}

