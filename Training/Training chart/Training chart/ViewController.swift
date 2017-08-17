//
//  ViewController.swift
//  Training chart
//
//  Created by Jeff on 16/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    
    @IBOutlet weak var lineView: LineChartView!
    
    var data : [Double] = [Double(arc4random_uniform(14) + 1)]

    var timer = Timer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for _ in 1...14 {
        data.append(Double(arc4random_uniform(14) + 1))
        }
        
        Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(updateChartWithData2), userInfo: nil, repeats: true)
        updateChartWithData()
        //startUpdateChart()
        //updateChartWithData2()
    }
    
    func startUpdateChart(){
        print(data)
        data.remove(at: 0)
        data.append(Double(arc4random_uniform(14) + 1))
        
        
    }

    
    func updateChartWithData2() {
        startUpdateChart()

        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(data[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Visitor count")
        chartDataSet.drawCirclesEnabled = false
        
        
        let chartData = LineChartData(dataSet: chartDataSet)
        lineView.data = chartData
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = 14
        for i in 0..<visitorCounts {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(14))
            dataEntries.append(dataEntry)
        }
        let chartDataSet =
            BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
    }

    


    
}

