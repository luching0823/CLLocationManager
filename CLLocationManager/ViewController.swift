//
//  ViewController.swift
//  CLLocationManager
//
//  Created by 廖昱晴 on 2021/3/3.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization() //向使用者授權，拿取手機位置相關資訊
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest //設定準確度，Best為最高精準度
        locationManager?.activityType = .automotiveNavigation //模式(導航，健身....等)
        locationManager?.startUpdatingLocation() //每次更新地點資訊時，觸發delegate方法
        
        if let coordinate = locationManager?.location?.coordinate { //得到座標
            let xScale: CLLocationDegrees = 0.01 //橫向縮放
            let yScale: CLLocationDegrees = 0.01 //直向縮放
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale) //縮放範圍
            let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span) //顯示區域
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading //使用者位置保持在中心點，並依據轉向改變地圖方向
        
         
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation() //離開畫面後，停止更新地點資訊
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations[0].coordinate //最新座標
        print("------------------------------")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
    

}

