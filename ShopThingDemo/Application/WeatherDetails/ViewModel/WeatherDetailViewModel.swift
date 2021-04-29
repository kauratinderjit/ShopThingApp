//
//  WeatherDetailViewModel.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-23.
//

import Foundation
import SVProgressHUD

// MARK: - Protocol for DashBoardVC
protocol DashBoardVCDelegate
{
    func getData (list : WeatherData)
    func nothingFound(strMessage : String)
    func currentLocArrCount (byLat: String, byLong: String)
    func getLatLongOfSearchedCity (city: String)
}

class DashBoardViewModel
{
    var delegate : DashBoardVCDelegate
    var view : ViewController

    init(Delegate : DashBoardVCDelegate, view : ViewController)
    {
        delegate = Delegate
        self.view = view
    }

    // MARK: - To get data from api url For DashboardVC
    func currentCityWeatherData(endPoint : String) {
        SVProgressHUD.show()
        NetworkCall(data: [:], endpointUrl: endPoint, method: .get).executeQuery(){
                  (result: Result<SearchResultData,Error>) in
                  switch result{
                  case .success(let searchData):
                      print(searchData)
                    if searchData.count > 0 {
                        if [searchData[0].woeid].allNotNil(){
                          self.selectedCityDetail(woeid: searchData[0].woeid!)
                        }
                        else{
                            self.delegate.nothingFound(strMessage: "No weather data found")
                        }
                    }
                    else{
                        if [self.view.currentLat, self.view.currentLong].allNotNil() {
                            self.delegate.currentLocArrCount(byLat: self.view.currentLat!, byLong: self.view.currentLong!)
                        }
                        else {
                            self.delegate.nothingFound(strMessage: "No weather data found")
                        }
                    }
                  case .failure(let error):
                    self.delegate.nothingFound(strMessage: error.localizedDescription)
                  }
              }
        }
    
    // MARK: - To get data from api url For ChangeCityViewController
    func searchWeatherData(endPoint : String, cityName: String? = nil) {
        SVProgressHUD.show()
        NetworkCall(data: [:], endpointUrl: endPoint, method: .get).executeQuery(){
                  (result: Result<SearchResultData,Error>) in
                  switch result{
                  case .success(let searchData):
                      print(searchData)
                    if searchData.count > 0 {
                        if [searchData[0].woeid].allNotNil(){
                    self.selectedCityDetail(woeid: searchData[0].woeid!)
                        }
                        else{
                            self.delegate.nothingFound(strMessage: "No weather data found")
                        }
                    }
                    else{
                        if let strName = cityName {
                        self.delegate.getLatLongOfSearchedCity(city: strName)
                        }
                        else{
                            self.delegate.nothingFound(strMessage: "No weather data found")
                        }
                    }
                  case .failure(let error):
                    self.delegate.nothingFound(strMessage: error.localizedDescription)
                  }
              }
        }
    
    // MARK: - To get the data corrosponding to woeid
    func selectedCityDetail(woeid: Int) {
        let endPoint = "\(woeid)/"
        NetworkCall(data: [:], endpointUrl: endPoint, method: .get).executeQuery(){
                  (result: Result<WeatherData,Error>) in
                  switch result{
                  case .success(let weatherData):
                      print(weatherData)
                      self.delegate.getData(list: weatherData)
                  case .failure(let error):
                    self.delegate.nothingFound(strMessage: error.localizedDescription)
                  }
              }
    }

   
    // MARK: - To validate the required properties
func validationsForCurrentLocData(temp: String?, MinTemp: String?, MaxTemp: String?) throws
{
    guard let temp  = temp, !temp.isEmpty, !temp.trimmingCharacters(in: .whitespaces).isEmpty else
    {
        throw ValidationError.emptyTemp
    }
    
    guard let MinTemp  = MinTemp, !MinTemp.isEmpty, !MinTemp.trimmingCharacters(in: .whitespaces).isEmpty else
    {
        throw ValidationError.emptyMinTemp
    }
    
    guard let MaxTemp  = MaxTemp, !MaxTemp.isEmpty, !MaxTemp.trimmingCharacters(in: .whitespaces).isEmpty else
    {
        throw ValidationError.emptyMaxTemp
    }
}
    
    func displayData(info: ConsolidatedWeather,completionHandler: @escaping ((Bool)->Void)) {
        do {
            try validationsForCurrentLocData(temp: info.theTemp?.string, MinTemp: info.minTemp?.string, MaxTemp: info.maxTemp?.string)
            completionHandler(true)
        }
        catch let error {
            switch  error {
            case ValidationError.emptyTemp:
                self.view.globalAlert(msg: ValidationAlerts.kEmptyCurrentTemp)
                
            case ValidationError.emptyMinTemp:
                self.view.globalAlert(msg: ValidationAlerts.kEmptyMinTemp)
                
            case ValidationError.emptyMaxTemp:
                self.view.globalAlert(msg: ValidationAlerts.kEmptyMaxTemp)

            default:
                break
              
            }
        }
        
    }
            
}
