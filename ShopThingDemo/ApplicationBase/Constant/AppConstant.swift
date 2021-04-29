//
//  AppConstant.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-23.
//

import Foundation

struct ServiceLinking
{
    static let baseUrl = "https://www.metaweather.com/api/location/"
    static let weatherUrl = "https://www.metaweather.com/static/img/weather/png/64/"
}

struct EndPoint
{
    static let searchByLocName = "search/?query="
    static let searchByLatLong = "search/?lattlong="
}

struct AppCommonVariables
{
    static let kAppName = "WeatherForecast"
    static let kOk = "Ok"
    static let kDatabaseSuccess = "Database Success"
    static let kDatabaseFailure = "Database Failure"
 
}

struct ValidationAlerts
{
    static let kEmptyCurrentTemp = "Current temperature is not available"
    static let kEmptyMinTemp = "Min temperature is not available"
    static let kEmptyMaxTemp = "Max temperature is not available"
 
}




