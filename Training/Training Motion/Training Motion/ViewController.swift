//
//  ViewController.swift
//  Training Motion
//
//  Created by Jeff on 03/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation
import Charts

class ViewController: UIViewController {

    
    
    /// ---------------------------------------- Class attributes  -------------------------------
    
    let CM = CMMotionManager()
    var timer : Timer?
    var user = String()
    var datamotion : [String:[Double]] = ["x":[0],"y":[0],"z":[0]]
    var datarotate : [String:[Double]] = ["x":[0],"y":[0],"z":[0]]
    var dataplot : [String:[Double]] = ["x":[],"y":[],"z":[]]

    @IBOutlet weak var textZ: UILabel!
    @IBOutlet weak var textY: UILabel!
    @IBOutlet weak var textX: UILabel!
    
    /// ---------------------------------------- Outlet  -------------------------------
    @IBOutlet weak var lineView: LineChartView!
    @IBOutlet weak var lineView2: LineChartView!
    @IBOutlet weak var userText: UILabel!
    
    /// ---------------------------------------- Override superclass methods  -------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        CM.deviceMotionUpdateInterval=1/20

        userText.text!=user

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /// ---------------------------------------- Start tracking  -------------------------------
    
    @IBAction func startTracking(_ sender: UIButton) {
        
        if(sender.title(for: .normal)! == "Start tracking"){
            sender.setTitle("Stop tracking", for: .normal)
           // datamotion  = ["x":[0],"y":[0],"z":[0],"user":[user]]

            
        CM.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical,to: OperationQueue.current!,withHandler: { (data, error) in
                if let mydata = data
                {
                    
                    let x1 = mydata.userAcceleration.x
                    let y1 = mydata.userAcceleration.y
                    let z1 = mydata.userAcceleration.z
                    
                    self.datamotion["x"]!.append(x1)
                    self.datamotion["y"]!.append(y1)
                    self.datamotion["z"]!.append(z1)
                    
                    
                    
                    let x = mydata.attitude.roll*180/3.1415
                    let y =  mydata.attitude.pitch*180/3.1415
                    let z =  mydata.attitude.yaw*180/3.1415
                    
                    
                    self.datarotate["x"]!.append(x)
                    self.datarotate["y"]!.append(y)
                    self.datarotate["z"]!.append(z)
                    
                    self.updateChartWithData()
                    self.updateChartWithDataRotate()
                    
                    self.textX.text=String(Int(x))+" °"
                    self.textY.text=String(Int(y))+" °"
                    self.textZ.text=String(Int(z))+" °"

                    
                }
                
                
            })

            
            
            
            
        }else{
            sender.setTitle("Start tracking", for: .normal)
            CM.stopAccelerometerUpdates()
            CM.stopDeviceMotionUpdates()

            SendData()
            //datamotion  = ["x":[0],"y":[0],"z":[0],"user":[user]]
            datamotion  = ["x":[],"y":[],"z":[]]
            datarotate  = ["x":[],"y":[],"z":[]]

        }
        
        
 
        }
    /// ---------------------------------------- Upload chart  motion -------------------------------

    
    
    func updateChartWithData() {

        
        var x1 = datamotion["x"]!
        var y1 = datamotion["y"]!
        var z1 = datamotion["z"]!

        
        if(x1.count>3){
            
        var band : Int = x1.count
        if(band > 50)
        {
        band=50
            }
        
        var x2=Array(x1[(x1.count-band)...(x1.count-1)])
        var y2=Array(y1[(y1.count-band)...(y1.count-1)])
        var z2=Array(z1[(z1.count-band)...(z1.count-1)])
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<x2.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(x2[i]))
            dataEntries.append(dataEntry)
        }

        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<y2.count {
            let dataEntry2 = ChartDataEntry(x: Double(i), y: Double(y2[i]))
            dataEntries2.append(dataEntry2)
        }

        var dataEntries3: [ChartDataEntry] = []
        for i in 0..<z2.count {
            let dataEntry3 = ChartDataEntry(x: Double(i), y: Double(z2[i]))
            dataEntries3.append(dataEntry3)
        }

        let chartDataSet = [LineChartDataSet(values: dataEntries, label: "X"),LineChartDataSet(values: dataEntries2, label: "Y"),LineChartDataSet(values: dataEntries3, label: "Z")]
        chartDataSet[0].drawCirclesEnabled = false
        chartDataSet[1].drawCirclesEnabled = false
        chartDataSet[2].drawCirclesEnabled = false

        chartDataSet[0].axisDependency = .left
        chartDataSet[0].setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        chartDataSet[1].axisDependency = .left
        chartDataSet[1].setColor(UIColor.blue.withAlphaComponent(0.5)) // our line's opacity is 50%
        chartDataSet[2].axisDependency = .left
        chartDataSet[2].setColor(UIColor.green.withAlphaComponent(0.5)) // our line's opacity is 50%
        
        chartDataSet[0].drawFilledEnabled = true
        chartDataSet[1].drawFilledEnabled = true
        chartDataSet[2].drawFilledEnabled = true

        chartDataSet[0].drawValuesEnabled = false
        chartDataSet[1].drawValuesEnabled = false
        chartDataSet[2].drawValuesEnabled = false
            
        chartDataSet[0].fillColor = UIColor.red.withAlphaComponent(0.2)
        chartDataSet[1].fillColor = UIColor.blue.withAlphaComponent(0.2)
        chartDataSet[2].fillColor = UIColor.green.withAlphaComponent(0.2)

        
    
        
        let chartData = LineChartData(dataSets: chartDataSet)
        
        lineView.leftAxis.drawGridLinesEnabled = false
        lineView.rightAxis.drawGridLinesEnabled = false
        lineView.rightAxis.enabled=false
        lineView.xAxis.drawGridLinesEnabled = false
        lineView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineView.chartDescription?.text = ""
        lineView.drawMarkers = false
        lineView.data = chartData
            
       lineView.leftAxis.axisMinimum = min(-2,lineView.data!.yMin)
       lineView.leftAxis.axisMaximum = max(2,lineView.data!.yMax )
       lineView.leftAxis.labelCount = Int(max(2,lineView.data!.yMax )-min(-2,lineView.data!.yMin))
            
         lineView.backgroundColor = UIColor(white: 1, alpha: 0)
            
        
        lineView.leftAxis.valueFormatter=DefaultAxisValueFormatter(block: {(value, _) in
            return String(Int(value)) + " G"
            
            
        })
            
        }
    }
    
    
    
    
    
    /// ---------------------------------------- Upload chart  rotate -------------------------------

    
    func updateChartWithDataRotate() {
        
        
        var x1 = datarotate["x"]!
        var y1 = datarotate["y"]!
        var z1 = datarotate["z"]!
        
        
        if(x1.count>3){
            
            var band : Int = x1.count
            if(band > 50)
            {
                band=50
            }
            
            var x2=Array(x1[(x1.count-band)...(x1.count-1)])
            var y2=Array(y1[(y1.count-band)...(y1.count-1)])
            var z2=Array(z1[(z1.count-band)...(z1.count-1)])
            
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<x2.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(x2[i]))
                dataEntries.append(dataEntry)
            }
            
            var dataEntries2: [ChartDataEntry] = []
            for i in 0..<y2.count {
                let dataEntry2 = ChartDataEntry(x: Double(i), y: Double(y2[i]))
                dataEntries2.append(dataEntry2)
            }
            
            var dataEntries3: [ChartDataEntry] = []
            for i in 0..<z2.count {
                let dataEntry3 = ChartDataEntry(x: Double(i), y: Double(z2[i]))
                dataEntries3.append(dataEntry3)
            }
            
            let chartDataSet = [LineChartDataSet(values: dataEntries, label: "roll"),LineChartDataSet(values: dataEntries2, label: "pitch"),LineChartDataSet(values: dataEntries3, label: "yaw")]
            chartDataSet[0].drawCirclesEnabled = false
            chartDataSet[1].drawCirclesEnabled = false
            chartDataSet[2].drawCirclesEnabled = false
            
            chartDataSet[0].axisDependency = .left
            chartDataSet[0].setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
            chartDataSet[1].axisDependency = .left
            chartDataSet[1].setColor(UIColor.blue.withAlphaComponent(0.5)) // our line's opacity is 50%
            chartDataSet[2].axisDependency = .left
            chartDataSet[2].setColor(UIColor.green.withAlphaComponent(0.5)) // our line's opacity is 50%
            
            chartDataSet[0].drawFilledEnabled = true
            chartDataSet[1].drawFilledEnabled = true
            chartDataSet[2].drawFilledEnabled = true
            
            chartDataSet[0].drawValuesEnabled = false
            chartDataSet[1].drawValuesEnabled = false
            chartDataSet[2].drawValuesEnabled = false
            
            chartDataSet[0].fillColor = UIColor.red.withAlphaComponent(0.2)
            chartDataSet[1].fillColor = UIColor.blue.withAlphaComponent(0.2)
            chartDataSet[2].fillColor = UIColor.green.withAlphaComponent(0.2)
            
            
            
            
            let chartData = LineChartData(dataSets: chartDataSet)
            
            lineView2.leftAxis.drawGridLinesEnabled = false
            lineView2.rightAxis.drawGridLinesEnabled = false
            lineView2.rightAxis.enabled=false
            lineView2.xAxis.drawGridLinesEnabled = false
            lineView2.xAxis.labelPosition = XAxis.LabelPosition.bottom
            lineView2.chartDescription?.text = ""
            lineView2.drawMarkers = false
            lineView2.data = chartData
            
            lineView2.leftAxis.axisMinimum = min(-180,lineView.data!.yMin)
            lineView2.leftAxis.axisMaximum = max(180,lineView.data!.yMax )
           lineView2.leftAxis.labelCount = Int(max(2,lineView.data!.yMax )-min(-2,lineView.data!.yMin))
            
            lineView2.backgroundColor = UIColor(white: 1, alpha: 0)
            
            
            lineView2.leftAxis.valueFormatter=DefaultAxisValueFormatter(block: {(value, _) in
                return String(Int(value)) + " R"
                
                
            })
            
        }
    }
    
    
    
    
    

    
    
    
    
    /// ---------------------------------------- Send data  -------------------------------

    func SendData() {
        
        
        do {
            let url = URL(string: "http://137.74.168.147:5000/try")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            
            let myjson = try! JSONSerialization.data(withJSONObject: datamotion, options: .prettyPrinted)
            
            
            let decoded = try JSONSerialization.jsonObject(with: myjson, options: [])
            
            if let dictFromJSON = decoded as? [String:String] {
                
                print(dictFromJSON)
            }
            
            
            request.httpBody = myjson
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil
                {
                    print(error!)
                }
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
            
        }catch {
            print("error from json")
            print(error)
        }
        
        
        
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
    }
    
    
    

}

