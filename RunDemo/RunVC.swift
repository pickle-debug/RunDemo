//
//  RunVC.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/8.
//

import Foundation

class RunVC: UIViewController, MAMapViewDelegate{
    @IBOutlet weak var mapView: MAMapView!
    var coordinateArray: [CLLocationCoordinate2D] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startLocation()
    }
    func initMapView(){
        mapView.delegate = self
        mapView.zoomLevel = 15.5
        mapView.distanceFilter = 3.0
        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    func startLocation(){
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true
    }
    func mapView(mapView: MAMapView,didUpdateUserLocation userLocation: MAUserLocation,updatingLocation:Bool){
        //地图每次有位置更新时回调
        if updatingLocation{
            //获取新的定位数据
            let coordinate = userLocation.coordinate
            
            //添加到保存定位点的数组
            self.coordinateArray.append(coordinate)
            
            updatePath()
        }
    }
    func updatePath(){
        //每次获取到新的定位点重新绘制路径
        
        //移除掉之前的overlay
        let overlays = self.mapView.overlays
        self.mapView.removeOverlays(overlays)
        
        let polyline = MAPolyline(coordinates: &self.coordinateArray, count: UInt(self.coordinateArray.count))
        self.mapView.add(polyline)
        
        //将最新的点定位到界面正中间显示
        let lastCoord = self.coordinateArray[self.coordinateArray.count - 1]
        self.mapView.setCenter(lastCoord,animated: true)
    }
    private func mapView(mapView: MAMapView!, viewForOverlay overlay:MAOverlay!) -> MAOverlayView! {
        if overlay.isKind(of: MAPolyline.self){
            let polylineView = MAPolylineView(overlay:  overlay)
            polylineView?.lineWidth = 6
            polylineView?.strokeColor = UIColor(red: 4 / 255.0, green: 181 / 255.0, blue: 108 / 255.0, alpha: 1.0)
            
            return polylineView
        }
        return nil
    }
    
}
