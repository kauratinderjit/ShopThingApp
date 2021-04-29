//
//  ShopThingDemoTests.swift
//  ShopThingDemoTests
//
//  Created by Atinder Kaur on 2021-04-23.
//

import XCTest
@testable import ShopThingDemo

class ShopThingDemoTests: XCTestCase {
    var sut = ViewController()
    var viewModel: DashBoardViewModel?
    // MARK: - Setup
    
   
    func testForCurrentCityWeatherDataByName(){
        self.viewModel = DashBoardViewModel.init(Delegate: sut, view: sut)
        NetworkCall(data: [:], endpointUrl: EndPoint.searchByLocName  + "toronto" , method: .get).executeQuery(){
                  (result: Result<SearchResultData,Error>) in
                  switch result{
                  case .success(let searchData):
                      print(searchData)
                        self.viewModel?.selectedCityDetail(woeid: searchData[0].woeid ?? 44418)
                  case .failure(let error):
                    print(error.localizedDescription)
                  }
              }
        
    }
    
    func testForCurrentCityWeatherDataByCoordinates(){
        self.viewModel = DashBoardViewModel.init(Delegate: sut, view: sut)
        NetworkCall(data: [:], endpointUrl: EndPoint.searchByLatLong  + "43.65,79.38" , method: .get).executeQuery(){
                  (result: Result<SearchResultData,Error>) in
                  switch result{
                  case .success(let searchData):
                      print(searchData)
                        self.viewModel?.selectedCityDetail(woeid: searchData[0].woeid ?? 44418)
                  case .failure(let error):
                    print(error.localizedDescription)
                  }
              }
        
    }
    
    func testForDataAccordingToWOEIDiD() {
        NetworkCall(data: [:], endpointUrl: "44418/", method: .get).executeQuery(){
                  (result: Result<WeatherData,Error>) in
                  switch result{
                  case .success(let weatherData):
                      print(weatherData)
                  case .failure(let error):
                   print(error.localizedDescription)
                  }
              }
    }
}
