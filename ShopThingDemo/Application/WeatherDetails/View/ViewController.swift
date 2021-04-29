//
//  ViewController.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-23.
//

import UIKit

class ViewController: BaseUIController {
    
    //Outlets
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var lblTempLevel: UILabel!
    @IBOutlet weak var tblWeatherForeCast: UITableView!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    //Variables
    var viewModel : DashBoardViewModel?
    var consolidatedWeatherList: [ConsolidatedWeather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK: Setting the view
    func setView(){
      self.tableAutomaticDimension(tbl: tblWeatherForeCast, estimatedHeight: 40)
        self.viewModel = DashBoardViewModel.init(Delegate: self, view: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getCurrentCityByName(notification:)), name: Notification.Name("locationUpdated"), object: nil)
    }
    
    //MARK: Getting the city name by current latitude and longitude
    @objc func getCurrentCityByName(notification: Notification) {
        if [currentLat, currentLong].allNotNil() {
            self.getAddressFromLatLon(currentLatitude: currentLat!, withLongitude: currentLong!) { cityName in
                self.apiCallByLocationName(name: cityName)
            }
          }
    }

    //MARK: Getting the data of current location via 'query' parameter
    func apiCallByLocationName(name : String) {
        self.viewModel?.currentCityWeatherData (endPoint: EndPoint.searchByLocName + name)
    }
    
    //MARK: Updating the UIView with data
    func updateViewWithData(city : String) {
        if consolidatedWeatherList?.count ?? 0 > 0 {
            self.viewModel?.displayData(info: (consolidatedWeatherList?[0])!) {_ in
                self.lblTempLevel.text = self.consolidatedWeatherList?[0].theTemp?.roundedValue(toPlaces: 2).string
            self.lblCity.text = city
                self.lblMinTemp.text = self.consolidatedWeatherList?[0].minTemp?.roundedValue(toPlaces: 2).string
                self.lblMaxTemp.text = self.consolidatedWeatherList?[0].maxTemp?.roundedValue(toPlaces: 2).string
                self.imgWeatherIcon.downloaded(from: Extended.shared.updateWeatherIcon(condition: (self.consolidatedWeatherList?[0].weatherStateAbbr)!))
        }
            self.tblWeatherForeCast.reloadData()
        }
        else{
            self.globalAlert(msg: "No weather data found")
        }
    }
    

    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}

