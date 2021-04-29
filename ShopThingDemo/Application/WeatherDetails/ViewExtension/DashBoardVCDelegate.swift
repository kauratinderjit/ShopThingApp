//
//  DashBoardVCDelegate.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-27.
//

import Foundation
import UIKit
import SVProgressHUD

//MARK: Delegate methods being called via view model

extension ViewController : DashBoardVCDelegate {
    
    func getLatLongOfSearchedCity(city: String) {
        self.getLatLongFromAddress(city: city) { lat, long in
            self.viewModel?.searchWeatherData(endPoint: "\(EndPoint.searchByLatLong)\(String(describing: lat)),\(String(describing: long))")
        }
    }
    
    func currentLocArrCount(byLat: String, byLong: String) {
        if [byLat, byLong].allNotNil() {
            self.viewModel?.currentCityWeatherData(endPoint:"\(EndPoint.searchByLatLong)\(String(describing: byLat)),\(String(describing: byLong))" )
        }
        else{
            self.globalAlert(msg: "No weather data found")
        }
    }
    
    
    func getData(list: WeatherData) {
        SVProgressHUD.dismiss()
        if let data =  list.consolidatedWeather {
            consolidatedWeatherList = data
            updateViewWithData(city: list.title ?? "")
        }
        else {
            self.globalAlert(msg: "No weather data found")
        }
        
    }
    
    func nothingFound(strMessage: String) {
        SVProgressHUD.dismiss()
        self.globalAlert(msg: strMessage)
    }
}
