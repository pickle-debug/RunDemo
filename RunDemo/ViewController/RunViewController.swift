
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
//    var locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    //总共移动的距离
    var travelDistance: Double = 0
    
    var locationManager:AMapLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
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
    func updateLabelWithLocation(location:CLLocation!){
        if startLocation == nil {
            startLocation = location.first
            
        }
        let speed = String(format: "%.2f", location.speed)
        self.speedLabel.text = speed
    }
    func startPedometerUpdates(){
        distanceLabel.text = "0.00"
        if CMPedometer .isStepCountingAvailable(){
            self.pedometer.startUpdates(from: Date(), withHandler: {pedometerData, error in
                guard error == nil else{
                    print (error!)
                    return
                }
                let distanceString = String(format: "%.2f",pedometerData?.distance as! CVarArg)
                self.distanceLabel.text = distanceString

//                DispatchQueue.main.async {
//                    self.distanceLabel.text = distanceText
//                }
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
    func amapLocationManager(_ manager: AMapLocationManager!,doRequireLocationAuth locationManager:CLLocationManager!){
        locationManager.requestAlwaysAuthorization()
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        updateLabelWithLocation(location)
    }
}

