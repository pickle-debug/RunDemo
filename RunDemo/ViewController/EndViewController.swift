//
//  EndViewController.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/12.
//

import UIKit

class EndViewController: UIViewController,MAMapViewDelegate {
    @IBOutlet weak var mapView :MAMapView!
    var coordinateArray: [CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
    }
    
    func initMapView(){
        mapView.delegate = self
        mapView.zoomLevel = 15.5
        mapView.distanceFilter = 3.0
        mapView.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidLoad(animated)
        startLocation()
    }
    
    func startLocation(){
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true
    }
    func mapView(mapView: MAMapView, didUpdateUserLocation userLocation:MAUserLocation,updatingLocation: Bool){
        if updatingLocation{
            let coordinate = userLocation.coordinate
            
            self.coordinateArray.append(coordinate)
            
            updatePath()
        }
    }
    func updatePath(){
        let overlays = self.mapView.overlays
        self.mapView.removeOverlays(overlays)
        
        let polyline = MAPolyline(coordinates: &self.coordinateArray, count: UInt(self.coordinateArray.count))
        self.mapView.addOverlays(polyline)
        
        let lastCoord = self.coordinateArray[self.coordinateArray.count - 1]
        self.mapView.setCenter(lastCoord, animated: true)
    }
    func mapView(mapView: MAMapView!, viewForOverlay overlay:MAOverlay!) -> MAOverlayView!{
        if overlay.isKindOfClass(MAPolyline){
            let polylineView = MAPolylineView(overlay: overlay)
            polylineView?.lineWidth = 6
            polylineView?.strokeColor  = UIColor(red: 4 / 255.0,green: 181 / 255.0, blue: 108 / 255.0, alpha: 1.0)
            
            return polylineView
        }
        return nil
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
