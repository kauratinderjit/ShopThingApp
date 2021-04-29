//
//  WeatherSearch.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-23.
//

import Foundation
// MARK: - Weather Search
struct SearchResult: Codable {
    let title, locationType: String?
    let woeid: Int?
    let lattLong: String?

    enum CodingKeys: String, CodingKey {
            case title
            case locationType = "location_type"
            case woeid
            case lattLong = "latt_long"
        }
}

typealias SearchResultData = [SearchResult]
