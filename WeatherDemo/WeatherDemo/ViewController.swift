//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Roger Yee on 5/14/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit

struct Weather {
    var city:City?
    var weather:String?
    var temp:String?
}

struct City {
    var cityId:String?
    var cityName:String?
}

class CityLabel : UILabel {
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 传递touch事件到下一个Responser（也就是ViewController）
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
}

class ViewController: UIViewController {

    var labelCity: CityLabel!
    var labelWeather: UILabel!
    var labelTemp: UILabel!
    var loadIndicator : UIActivityIndicatorView!
    var citySelectionViewController : CitySelectionViewController!
    
    var weatherData:Weather?{
        didSet{
            render()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch:UITouch? =  (touches.first as? UITouch)
        if touch != nil {
            if touch!.view === self.labelCity {
                selectCity()
            }
        }
    }
    
    func render(){
        
        if (self.weatherData!.city != nil) {
            self.labelCity.text = self.weatherData!.city?.cityName
        } else {
            self.labelCity.text = "点击选择城市"
        }
        
        if (self.weatherData!.weather != nil) {
            self.labelWeather.text = self.weatherData!.weather
        } else {
            self.labelWeather.text = "天气"
        }
        
        if (self.weatherData!.temp != nil) {
            self.labelTemp.text = self.weatherData!.temp
        } else {
            self.labelTemp.text = "温度"
        }
    }
    
    func selectCity() {
        if self.citySelectionViewController == nil {
            self.citySelectionViewController = CitySelectionViewController(parent: self)
        }
        self.presentViewController(self.citySelectionViewController, animated: true, completion: nil)
    }
    
    func backToViewController(city : City) {
        self.dismissViewControllerAnimated(true, completion: nil)
        loadWeather(city)
    }
    
    func loadWeather(city:City?) {
        
        if city == nil {
            return
        }
        
        // http://api.k780.com:88/?app=weather.today&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json&weaid=1
        var urlStr = "http://api.k780.com:88/?app=weather.today&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json&weaid=" + city!.cityId!
        
        var url:NSURL = NSURL(string: urlStr)!
        var request:NSURLRequest = NSURLRequest(URL: url)
        var session:NSURLSession = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            var httpResponse = response as! NSHTTPURLResponse
            if httpResponse.statusCode == 200 {
                var jsonData: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                let success:String = jsonData!.objectForKey("success") as! String
                if success == "1" {
                    var result:NSDictionary = (jsonData!.objectForKey("result") as? NSDictionary)!
                    
                    var weather = Weather()
                    weather.city = city
                    weather.temp = "温度：" + (result["temperature"] as! String)
                    
                    var weatherStr = (result["weather"] as! String)
                    var windStr = (result["wind"] as! String) + "(" + (result["winp"] as! String) + ")"
                    var humidity = (result["humidity"] as! String)
                    humidity = "湿度" + humidity
                    weather.weather = "天气：" + weatherStr + ", " + windStr + ", " + humidity
                    
                    self.weatherData = weather
                    self.loadIndicator.stopAnimating()
                }
            }
        })
        
        task.resume()
        self.loadIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.labelCity = CityLabel()
        self.labelCity.textColor=UIColor.blackColor()
        self.labelCity.backgroundColor=UIColor.whiteColor()
        self.labelCity.textAlignment = NSTextAlignment.Center
        self.labelCity.font = UIFont.systemFontOfSize(20)
        self.labelCity.text = "点击选择城市"
        self.labelCity.sizeToFit()
        self.labelCity.userInteractionEnabled = true // Enable Touch Events
        self.labelCity.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.labelCity)
        
        self.labelWeather = UILabel()
        self.labelWeather.textColor=UIColor.blackColor()
        self.labelWeather.backgroundColor=UIColor.whiteColor()
        self.labelWeather.textAlignment = NSTextAlignment.Center
        self.labelWeather.font = UIFont.systemFontOfSize(20)
        self.labelWeather.text = "天气"
        self.labelWeather.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.labelWeather)
        
        self.labelTemp = UILabel()
        self.labelTemp.textColor=UIColor.blackColor()
        self.labelTemp.backgroundColor=UIColor.whiteColor()
        self.labelTemp.textAlignment = NSTextAlignment.Center
        self.labelTemp.font = UIFont.systemFontOfSize(20)
        self.labelTemp.text = "温度"
        self.labelTemp.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.labelTemp)
        
        self.loadIndicator = UIActivityIndicatorView(frame: CGRectMake(150, 90, 80, 80))
        self.loadIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.loadIndicator.color = UIColor.blueColor()
        self.loadIndicator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.loadIndicator)
        
        let views = ["labelCity":self.labelCity, "labelWeather":self.labelWeather, "labelTemp":self.labelTemp]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[labelCity]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[labelWeather]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[labelTemp]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[labelCity(==50)]-50-[labelWeather(==70)]-50-[labelTemp(==50)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        
        self.view.addConstraints([NSLayoutConstraint(item: self.labelCity, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: self.labelWeather, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: self.labelTemp, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: self.loadIndicator, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: self.loadIndicator, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -100.0)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CitySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var parent:ViewController!
    var tableView : UITableView!
    var loadIndicator : UIActivityIndicatorView!
    var cityList:Array<City> = Array()
    var selectedCity:City!
    
    init(parent:ViewController) {
        super.init(nibName: nil, bundle: nil)
        self.parent = parent
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
//        var button = UIButton(frame:CGRectMake(0, 20, 100, 20))
//        button.setTitle("按钮", forState:UIControlState.Normal)
//        button.setTitleColor(UIColor.blackColor(),forState: .Normal)
//        button.backgroundColor=UIColor.whiteColor()
//        button.addTarget(self,action:Selector("tapped:"),forControlEvents:UIControlEvents.TouchUpInside)
//        self.view.addSubview(button)
        
        self.tableView = UITableView()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.tableView)
        
        self.loadIndicator = UIActivityIndicatorView(frame: CGRectMake(150, 90, 80, 80))
        self.loadIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.loadIndicator.color = UIColor.blueColor()
        self.loadIndicator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.loadIndicator)
        
        var views = ["tableView": self.tableView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views));
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-21-[tableView]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        self.view.addConstraints([NSLayoutConstraint(item: self.loadIndicator, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)])
        self.view.addConstraints([NSLayoutConstraint(item: self.loadIndicator, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -20.0)])
        
        loadCities()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.textLabel!.text = self.cityList[indexPath.row].cityName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCity = self.cityList[indexPath.row]
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        parent.backToViewController(self.selectedCity)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func loadCities() {
        var url:NSURL = NSURL(string: "http://api.k780.com:88/?app=weather.city&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!
        var request:NSURLRequest = NSURLRequest(URL: url)
        var session:NSURLSession = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            var httpResponse = response as! NSHTTPURLResponse
            if httpResponse.statusCode == 200 {
                var jsonData: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil)
                let success:String = jsonData!.objectForKey("success") as! String
                if success == "1" {
                    var cities:NSDictionary = (jsonData!.objectForKey("result") as? NSDictionary)!
                    
                    var cityName:String, cityId:String, city:City
                    for temp in cities.allValues {
                        var tempDic = temp as! NSDictionary
                        cityName = tempDic["citynm"] as! String
                        cityId = tempDic["cityid"] as! String
                        city = City(cityId: cityId, cityName: cityName)
                        self.cityList.append(city)
                    }
                    
                    println("cities.count = \(cities.count)")
                }
            }
            
            self.tableView.reloadData()
            self.loadIndicator.stopAnimating()
            println("response.status = \(httpResponse.statusCode) and load cities completed.")
        })
        
        task.resume()
        self.loadIndicator.startAnimating()
    }
}

