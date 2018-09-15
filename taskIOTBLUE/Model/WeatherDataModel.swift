//
//  WeatherDataModel.swift
//  taskIOTBLUE
//
//  Created by shady on 9/15/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

class WeatherDataModel: UIViewController {
    
    var temprature :Int = 0
    
    var conition : Int = 0
    
    var city : String = " "
    
    var status : String = " "
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "storm"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower"
            
        case 601...700 :
            return "snow"
            
        case 701...771 :
            return "fog"
            
        case 772...800 :
            return "storm"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy"
            
        case 900...903, 905...1000  :
            return "storm"
            
        case 903 :
            return "snow"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
    
    

}
