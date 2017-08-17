//
//  TemporyViewController.swift
//  Training Motion
//
//  Created by Jeff on 03/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation


class TemporyViewController: UIViewController {

    
    let CM = CMMotionManager()
    var timer : Timer?
    var datamotion : [String:[Double]] = ["x":[0],"y":[0],"z":[0]]
    private let refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CM.deviceMotionUpdateInterval=1/6
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func startTracking(_ sender: UIButton) {
        
        if(sender.title(for: .normal)! == "Start tracking"){
            sender.setTitle("Stop tracking", for: .normal)
            func helloWorldTimer () {
                timer = Timer.scheduledTimer(timeInterval: 1/120, target: self, selector: #selector(TemporyViewController.tracking), userInfo: nil, repeats: true)}
            helloWorldTimer()
            
            
        }else{
            sender.setTitle("Start tracking", for: .normal)
            timer?.invalidate()
            endTracking()
            SendData()
        }
    }
    
    
    func tracking()
    {
        
        CM.startAccelerometerUpdates()
        
        if (CM.accelerometerData?.acceleration.x) != nil
        {
            let x = CM.accelerometerData?.acceleration.x
            let y = CM.accelerometerData?.acceleration.y
            let z = CM.accelerometerData?.acceleration.z
            
            datamotion["x"]!.append(x!)
            datamotion["y"]!.append(y!)
            datamotion["z"]!.append(z!)
            
            print(x!)
        }else{
            
        }
        
        
    }
    
    func endTracking()
    {
        
        print(datamotion)
        CM.stopAccelerometerUpdates()
        
        
    }
    
    func SendData() {
        
        
        do {
            let url = URL(string: "http://137.74.168.147/json")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            
            //            let datamotion2=["username":"jeff", "password":"qin"]
            
            
            let myjson = try! JSONSerialization.data(withJSONObject: datamotion, options: .prettyPrinted)
            let valid = JSONSerialization.isValidJSONObject(myjson)
            print(valid)
            
            let decoded = try JSONSerialization.jsonObject(with: myjson, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:String] {
                
                print(dictFromJSON)
            }
            
            
            request.httpBody = myjson
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            print(request.httpBody)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil
                {print(error)}
                else{
                    if let content = data {
                        do {
                            let myjson = try JSONSerialization.jsonObject(with: content, options: []) as AnyObject!
                            print(myjson!)
                        }
                            
                        catch{
                            print("error from api")
                            print(content)}
                        
                    }
                    
                }}
            task.resume()
            refreshControl.endRefreshing()
            //p/rint(myjson)
            
        }catch {
            print("error from json")
            print(error)
        }
        
        
        
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
    }


}
