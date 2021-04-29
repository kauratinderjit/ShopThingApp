//
//  ChangeCityDelegate.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-27.
//

import Foundation


extension ViewController : ChangeCityDelegate {
    //Write userEnteredANewCityName Delegate method here:
    
    func userEnteredANewCityName(city: String) {
        self.viewModel?.searchWeatherData(endPoint: EndPoint.searchByLocName + city, cityName: city)
    }
}

