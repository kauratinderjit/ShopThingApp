//
//  ListExtension.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-27.
//

import Foundation
import UIKit

extension Collection where Element == Optional<Any> {
func allNil() -> Bool {
    return allSatisfy { $0 == nil }
}
func anyNil() -> Bool {
    return first { $0 == nil } != nil
}
func allNotNil() -> Bool {
    return !allNil()
}
   
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundedValue(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

