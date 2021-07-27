
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/2.
//

import UIKit
import CoreLocation
import CoreMotion

class RunViewController: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var centerButton: UIButton!
    
    var timer = Timer()
    let pedometer = CMPedometer()
    var time = 0
    var locateCount = 0
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    //总共移动的距离
    var travelDistance: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
    }
    @IBAction func startAction(_ sender: UIButton){
        if(centerButton.titleLabel?.text == "开始统计"){
            startPedometerUpdates()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(chronography), userInfo: nil, repeats: true)
            centerButton.setTitle("停止统计", for: .normal)
        }else{
            self .pedometer.stopUpdates()
            timer.invalidate()
            centerButton.setTitle("开始统计", for: .normal)
        }
    }
    func startPedometerUpdates(){
        distanceLabel.text = "0.00"
        if CMPedometer .isStepCountingAvailable(){
            self.pedometer.startUpdates(from: Date(), withHandler: {pedometerData, error in
                guard error == nil else{
                    print (error!)
                    return
                }
                let distanceText = pedometerData?.distance
                var speed = ""
                if let currentPace = pedometerData?.currentPace{
                    speed += "\(currentPace)"
                }
                DispatchQueue.main.async {
                    self.distanceLabel.text = "\(Double(distanceText!))"
                    self.speedLabel.text = speed
                }
            })
        }else {
            self.distanceLabel.text = "当前距离不可读"
        }
    }
    @objc func chronography() {
        time += 1
        timeLabel.text = String(format: "%02d:%02d", time/60,time%60)
    }
    //计时器
}

