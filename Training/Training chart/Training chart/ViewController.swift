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
    var data2 : [Double] = [Double(arc4random_uniform(14) + 1)]

    var timer = Timer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for _ in 1...14 {
        data.append(Double(arc4random_uniform(14) + 1))
            data2.append(Double(arc4random_uniform(14) + 1))

        }
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateChartWithData2), userInfo: nil, repeats: true)
        updateChartWithData()
        //startUpdateChart()
        //updateChartWithData2()
    }
    
    func startUpdateChart(){
        data.remove(at: 0)
        data.append(Double(arc4random_uniform(14) + 1))
        data2.remove(at: 0)
        data2.append(Double(arc4random_uniform(14) + 1))
        
        
    }

    
    func updateChartWithData2() {
        startUpdateChart()

        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(data[i]))
            dataEntries.append(dataEntry)
        }
        
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<data2.count {
            let dataEntry2 = ChartDataEntry(x: Double(i), y: Double(data2[i]))
            dataEntries2.append(dataEntry2)
        }
        
        let chartDataSet = [LineChartDataSet(values: dataEntries, label: "Visitor count"),LineChartDataSet(values: dataEntries2, label: "Visitor count 2")]
        chartDataSet[0].drawCirclesEnabled = false
        chartDataSet[1].drawCirclesEnabled = false

        chartDataSet[0].axisDependency = .left
        chartDataSet[0].setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%

        chartDataSet[1].axisDependency = .left
        chartDataSet[1].setColor(UIColor.blue.withAlphaComponent(0.5)) // our line's opacity is 50%
        
        chartDataSet[0].drawFilledEnabled = true
        chartDataSet[1].drawFilledEnabled = true
        
        chartDataSet[0].fillColor = UIColor.red.withAlphaComponent(0.2)
        chartDataSet[1].fillColor = UIColor.blue.withAlphaComponent(0.2)



        /*
        set1.axisDependency = .Left // Line will correlate with left axis values
         set1.setColor(UIColor.redColor().colorWithAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.redColor()) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.redColor()
        set1.highlightColor = UIColor.whiteColor()
        set1.drawCircleHoleEnabled = true
    */
        
        let chartData = LineChartData(dataSets: chartDataSet)
     
        lineView.leftAxis.drawGridLinesEnabled = false
        lineView.rightAxis.drawGridLinesEnabled = false
        lineView.rightAxis.enabled=false
        lineView.xAxis.drawGridLinesEnabled = false
        lineView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineView.chartDescription?.text = ""


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

