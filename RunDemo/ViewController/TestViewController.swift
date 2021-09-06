////
////  ViewController.swift
////  hangge_1544
////
////  Created by hangge on 2017/7/31.
////  Copyright © 2017年 hangge.com. All rights reserved.
////
//
import UIKit
import MapKit
import CoreMotion

class TestViewController: UIViewController, CLLocationManagerDelegate {

    //用来显示计步器统计信息
    @IBOutlet weak var label1: UILabel!

    //用来显示GPS统计信息
    @IBOutlet weak var label2: UILabel!

    //计步器对象
    let pedometer = CMPedometer()

    //定位管理器
    let locationManager = CLLocationManager()
    //最开始的坐标
    var startLocation: CLLocation!
    //上一次的坐标
    var lastLocation: CLLocation!
    //总共移动的距离（实际距离）
    var traveledDistance: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //开始统计按钮点击
    @IBAction func startButtonTap(_ sender: Any) {

        let button = sender as! UIButton
        if( button.titleLabel?.text == "开始统计" ){
            //开始获取步数计数据
            startPedometerUpdates()
            //开始获取GPS数据
            startLocationUpdates()
            //按钮改变
            button.setTitle("停止统计", for: .normal)
        }else{
            self.pedometer.stopUpdates()
            self.locationManager.stopUpdatingLocation()
            //按钮改变
            button.setTitle("开始统计", for: .normal)
        }
    }

    //开始获取步数计数据
    func startPedometerUpdates() {
        label1.text = ""

        //判断设备支持情况
        if CMPedometer.isStepCountingAvailable() {
            //初始化并开始实时获取数据
            self.pedometer.startUpdates (from: Date(), withHandler: {
                pedometerData, error in
                //错误处理
                guard error == nil else {
                    print(error!)
                    return
                }

                //获取各个数据
                var text = "--- 计步器统计数据 ---\n"
                if let distance = pedometerData?.distance {
                    text += "行走距离: \(distance)\n"
                }
                if let numberOfSteps = pedometerData?.numberOfSteps {
                    text += "行走步数: \(numberOfSteps)\n"
                }

                //在线程中更新文本框数据
                DispatchQueue.main.async{
                    self.label1.text = text
                }
            })

        }else {
            self.label1.text = "\n当前设备不支持获取步数\n"
            return
        }
    }

    //开始获取GPS数据
    func startLocationUpdates() {
        label2.text = ""
        startLocation = nil
        traveledDistance = 0

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.distanceFilter = 10
        }
    }

    //定位数据更新
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            //获取各个数据
            traveledDistance += lastLocation.distance(from: location)
            let lineDistance = startLocation.distance(from: locations.last!)
            var text = "--- GPS统计数据 ---\n"
            text += "实时距离: \(traveledDistance)\n"
            text += "直线距离: \(lineDistance)\n"
            label2.text = text

        }
        lastLocation = locations.last
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}



