//
//  ViewController.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/6/29.
//

import UIKit

class TestViewController: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate {
    var locationManager:AMapLocationManager!
    var locateCount : Int = 0
    var locationgInfoLabel:UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()
        self.title = "后台定位"
//        AMapServices.shared().enableHTTPS = true
//        let mapView = MAMapView(frame: self.view.bounds)
//        mapView.delegate = self
//        mapView.delegate = self
//        mapView.isShowsUserLocation = true
//        mapView.userTrackingMode = .follow
//        self.view.addSubview(mapView)
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.locatingWithReGeocode = true
        
        configSubView()
        configToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(false, animated: false);
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.startUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func configSubView(){
        locationgInfoLabel = UILabel(frame: CGRect(x: 40, y:40, width: self.view.bounds.width - 80,height:self.view.bounds.height - 150))
        locationgInfoLabel.backgroundColor = UIColor.clear
        locationgInfoLabel.textColor = UIColor.black
        locationgInfoLabel.font = UIFont.systemFont(ofSize: 14)
        locationgInfoLabel.adjustsFontSizeToFitWidth = true
        locationgInfoLabel.textAlignment = .left
        locationgInfoLabel.numberOfLines = 0
        
            self.view.addSubview(locationgInfoLabel)
        
    }
    func configToolBar(){
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let segmentControl = UISegmentedControl(items: ["开始后台定位","停止后台定位"])
        segmentControl.addTarget(self, action: #selector(self.locateAction(sender:)), for: UIControl.Event.valueChanged)
        let segmentItem = UIBarButtonItem(customView: segmentControl)
        self.toolbarItems = [flexibleItem, segmentItem, flexibleItem]
        
        segmentControl.selectedSegmentIndex = 0
    }
    @objc func locateAction(sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 1{
            locationManager.stopUpdatingLocation()
            self.locateCount = 0
        }else {
            locationManager.startUpdatingLocation()
        }
    }
        //开启持续定位
//        locationManager.startUpdatingLocation()
    func updateLabeLWithLocation(_ location:CLLocation!, regeocode: AMapLocationReGeocode?) {
        
        var infoString = String(format:"连续定位完成:%d\n\n回调时间:%@\n经 度:%.6f\n纬 度:%.6f\n精 度:%.3f米\n海 拔:%.3f米\n速 度:%.3f\n角 度:%.3f\n", self.locateCount,location.timestamp.description,
                                location.coordinate.longitude,location.coordinate.latitude,
                                location.horizontalAccuracy,location.altitude,location.speed,location.course)
        
//        if regeocode != nil {
//            let regeoString = String(format:"国家:%@\n省:%@\n市:%@\n城市编码:%@\n区:%@\n区域编码:%@\n地 址:%@\n兴趣点:%@\n",regeocode!.country, regeocode!.province, regeocode!.city, regeocode!.citycode,regeocode!.district, regeocode!.adcode,regeocode!.formattedAddress,regeocode!.poiName)
//            infoString = infoString + regeoString
//        }
//        self.locationgInfoLabel.text = infoString
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("Error:\(error)")
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        print("Location:\(location)")
        
        self.locateCount += 1
        updateLabeLWithLocation(location, regeocode: reGeocode)
    }
        //接收定位结果回调
//        func amapLocationManager(_ manager:AMapLocationManager!,didUpdate location:CLLocation!,reGeocode:AMapLocationReGeocode!){
//            print("Location:\(location)")
//            NSLog("location:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude);accuracy:\(location.horizontalAccuracy);};");
//            if let reGeocode=reGeocode{
//                NSLog("reGeocode:%@",reGeocode)
//            }
//        self.locationManager.requestLocation(withReGeocode: true){
//            (location,regeocode,error) -> Void in
//            print("\(regeocode)")
//        }
//        self.locationManager.locationTimeout = 6
//        self.locationManager.reGeocodeTimeout = 3
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
}
        
    
                
