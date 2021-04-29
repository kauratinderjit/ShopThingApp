//
//  MainViewExtension.swift
//  ShopThingDemo
//
//  Created by Atinder Kaur on 2021-04-28.
//

import Foundation

class Extended : NSObject  {
    
    static let shared = Extended()

    private override init()
    {
        super.init()
    }
    
   func updateWeatherIcon(condition: String) -> String {
        
    switch (condition) {
    
        case "sn" :
            return ServiceLinking.weatherUrl + "sn.png"
        
        case "sl" :
            return ServiceLinking.weatherUrl + "sl.png"
        
        case "h" :
            return ServiceLinking.weatherUrl + "h.png"
        
        case "t" :
            return ServiceLinking.weatherUrl + "t.png"
        
        case "hr" :
            return ServiceLinking.weatherUrl + "hr.png"
        
        case "lr" :
            return ServiceLinking.weatherUrl + "lr.png"
        
        case "s" :
            return ServiceLinking.weatherUrl + "s.png"
        
        case "hc" :
            return ServiceLinking.weatherUrl + "hc.png"
        
        case "lc"  :
            return ServiceLinking.weatherUrl + "lc.png"
        
        case "c" :
            return ServiceLinking.weatherUrl + "c.png"
        
       
        default :
            return ServiceLinking.weatherUrl + "c.png"
        }

    }
}
