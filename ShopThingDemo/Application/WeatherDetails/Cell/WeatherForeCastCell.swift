//
//  WeatherForeCastCell.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-28.
//

import UIKit

class WeatherForeCastCell: UITableViewCell {
    
    //Objects
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var imgWeatherState: UIImageView!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Displaying the data in the UITableView
    func setDataForNextFiveDays(index : Int, data: ConsolidatedWeather, delegate: DashBoardViewModel) {
        delegate.displayData(info: data) {_ in
         self.weekDay.text = data.applicableDate
        self.minTemp.text = data.minTemp?.roundedValue(toPlaces: 2).string
        self.maxTemp.text = data.maxTemp?.roundedValue(toPlaces: 2).string
            
            self.imgWeatherState.downloaded(from: Extended.shared.updateWeatherIcon(condition: (data.weatherStateAbbr)!))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
