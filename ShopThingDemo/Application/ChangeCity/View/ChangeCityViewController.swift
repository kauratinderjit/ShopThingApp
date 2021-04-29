//
//  ChangeCityViewController.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-23.
//
import UIKit


//Write the protocol declaration here:
protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}


class ChangeCityViewController: BaseUIController {
    
    //Declare the delegate variable here:
    var delegate : ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!

    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        if changeCityTextField.text != "" {
        //1 Get the city name the user entered in the text field
        let cityName = changeCityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let freedSpaceString = cityName.filter {!$0.isWhitespace}
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        delegate?.userEnteredANewCityName(city: freedSpaceString)
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil)
        }
        else {
            self.globalAlert(msg: "Enter city name")
        }
        
    }
    
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
