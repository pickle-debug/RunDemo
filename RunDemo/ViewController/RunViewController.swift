
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/2.
//

import UIKit
import CoreMotion
import CoreMotion

class RunViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var centerButton: UIButton!
//    var mapView: MAMapView!
    var timer = Timer()
    var time = 0
    var locationManager = CLLocationManager()
    var firstLocation: CLLocation!
    var lastLocation: CLLocation!
    //总共移动的距离
    var travelDistance: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startAction(_ sender: UIButton){
        if(centerButton.titleLabel?.text == "开始统计"){
            startLocationUpdates()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(chronography), userInfo: nil, repeats: true)
            centerButton.setTitle("停止统计", for: .normal)
        }else{
            self.locationManager.stopUpdatingLocation()
            timer.invalidate()
            centerButton.setTitle("开始统计", for: .normal)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if firstLocation == nil {
            firstLocation = locations.first
        }else if let location = locations.last{
            travelDistance += lastLocation.distance(from: location)
            distanceLabel.text = String(format:"%02d", travelDistance)
        }
        lastLocation = locations.last
    }
    func startLocationUpdates(){
        firstLocation = nil
        travelDistance = 0
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.distanceFilter = 10
        }
    }
    override  func  didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()

    }
    @objc func chronography() {
        time += 1
        timeLabel.text = String(format: "%02d:%02d", time/60,time%60)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

