//
//  BarChartViewController.swift
//  iOSChartDemo
//
//  Created by Roger Yee on 6/26/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {

    var chartView : BarChartView!
    
    var months : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        render()
        
        self.months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 14.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        setChart(self.chartView,dataPoints: self.months, values: unitSold)
    }
    
    func render() {
        self.title = "Bar Chart"
        
        self.navigationController?.navigationBar.translucent = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.chartView = BarChartView()
        self.chartView.delegate = self
        self.chartView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.chartView)
        
        let views = ["chart":self.chartView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[chart]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[chart]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
    }
    
    func setChart(barChart:BarChartView, dataPoints:[String], values:[Double]) {
        barChart.noDataText = "Please provide data for the chart"
        barChart.descriptionText = "Description should be hidden"
        
        var dataEntries : [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let dataSet = BarChartDataSet(yVals: dataEntries, label: "unitSold")
        
        // Customize the color or ColorTemplates
//        dataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1.0)]
        dataSet.colors = ChartColorTemplates.joyful()
        
        barChart.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        barChart.xAxis.labelPosition = .Bottom
        
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: ChartEasingOption.EaseInBounce)
        
        // Limit Line
        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        barChart.rightAxis.addLimitLine(ll)
        
        barChart.data = BarChartData(xVals: dataPoints, dataSet: dataSet)
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        println("\(entry.value) in \(self.months[entry.xIndex])")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
