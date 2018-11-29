//
//  WBLocationManager.swift
//  WBNetSupportDemo
//
//  Created by bi we on 2018/11/28.
//  Copyright © 2018 bi we. All rights reserved.
//

import UIKit
import CoreLocation
class WBLocationManager: NSObject,CLLocationManagerDelegate {
    static let shared:WBLocationManager = {
        let loc = WBLocationManager()
        return loc
    }()
    var currLocation:String = "0,0"
    //定位管理
    let locationManager:CLLocationManager = CLLocationManager()
    
    func prepareLocalManger() {
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways))
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }else{
            //授权请求
            //将选项弹出
            print("定位请求")
        }
        
    }
    
    
    //定位代理方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //获取最新的坐标
        if let  lastLocation = locations.last {
            currLocation = "\(lastLocation.coordinate.longitude),\(lastLocation.coordinate.latitude)"
            //获取经度
            print("经度：\(lastLocation.coordinate.longitude)")
            
            //获取纬度
            print("纬度：\(lastLocation.coordinate.latitude)")
        }
        
    }
    
}

