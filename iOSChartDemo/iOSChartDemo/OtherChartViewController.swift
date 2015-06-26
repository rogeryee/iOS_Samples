//
//  OtherChartViewController.swift
//  iOSChartDemo
//
//  Created by Roger Yee on 6/26/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import Charts

class OtherChartViewController: UIViewController {

    var lineChart : LineChartView!
    var pieChart : PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        render()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: unitsSold)
    }
    
    func render() {
        self.title = "Others"
        
        self.navigationController?.navigationBar.translucent = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.lineChart = LineChartView()
        self.lineChart.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.lineChart)
        
        self.pieChart = PieChartView()
        self.pieChart.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.pieChart)
        
        let views = ["line":self.lineChart, "pie":self.pieChart]
        let metrics = ["height":self.view.frame.height/2 - 30]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[line]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[pie]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[line(==height)]-10-[pie(==height)]|", options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views))
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        self.pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        self.lineChart.data = lineChartData
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
