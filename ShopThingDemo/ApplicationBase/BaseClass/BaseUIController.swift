//
//  BaseUIController.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-27.
//

import UIKit
import CoreLocation
import SVProgressHUD



class BaseUIController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentLat : String?
    var currentLong : String?
    var city : String?
    var geoCoder: CLGeocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func tableAutomaticDimension(tbl : UITableView, estimatedHeight : CGFloat) {
        tbl.tableFooterView = UIView()
        tbl.estimatedRowHeight = estimatedHeight
        tbl.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //Write the didUpdateLocations method here:
    //CLLocaton is an array, that stores location data in an every increasing accuracy fashion
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        // Accruate locations cant be negative
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longtiude = \(location.coordinate.longitude) and latitude = \(location.coordinate.latitude)")
            
            currentLat = String(location.coordinate.latitude)
            currentLong = String(location.coordinate.longitude)
            NotificationCenter.default.post(name: Notification.Name("locationUpdated"), object: nil)

        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    func getAddressFromLatLon(currentLatitude: String, withLongitude currentLongitude: String, handler: @escaping ((String)->Void)) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(currentLatitude)")!
            let lon: Double = Double("\(currentLongitude)")!
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        geoCoder.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        self.globalAlert(msg: "No weather data found")
                    }
                    let pm = placemarks! as [CLPlacemark]
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        if pm.locality != nil {
                           let addressString =  pm.locality!
                            self.city = addressString
                            handler(addressString)
                        }
                  }
            })
        }
    
    func getLatLongFromAddress(city: String, handler: @escaping ((String,String)->Void)){
      //  let address = "1 Infinite Loop, Cupertino, CA 95014"
            geoCoder.geocodeAddressString(city) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    self.globalAlert(msg: "No weather data found")
                    return
                }
                // Use your location
                handler(location.coordinate.latitude.string,location.coordinate.longitude.string)
            }
    }
    
    func dateFormatterFromCurrentData (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        print(formatter.string(from: date))
        formatter.dateFormat = "yyyy-MM-dd"
        let datetime = formatter.string(from: date)
        return datetime
    }
    
    
    func globalAlert(msg: String) {
        SVProgressHUD.dismiss()
        let alert = UIAlertController(title: AppCommonVariables.kAppName, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppCommonVariables.kOk, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
