//
//  TableViewDelegates.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-28.
//

import Foundation
import UIKit

//MARK: UITableView Delegate and Data Source Methods

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consolidatedWeatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherForeCast", for: indexPath) as? WeatherForeCastCell else {
            return UITableViewCell()
          }
        cell.setDataForNextFiveDays(index: indexPath.row, data: (consolidatedWeatherList?[indexPath.row])!, delegate: self.viewModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
}
