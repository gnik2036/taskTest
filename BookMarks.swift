//
//  BookMarks.swift
//  taskIOTBLUE
//
//  Created by shady on 9/12/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Alamofire
import SwiftyJSON

protocol UpdateLocations
{
    func receivedLocations (locationsContainerUpdate:[String],lat :[String] ,lon: [String])
}

class BookMarks: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var locationsContainer = [String]()
    
    var locationsContainerlon = [String]()
    
    var locationsContainerlat = [String]()
    
    var delegate : UpdateLocations?
    
    let  AppID : String = "f9f89e3f8df9497aef7f3556f912f872"
    
    let weatherURL:String = "https://api.openweathermap.org/data/2.5/weather"
    
    let weatherDataMode = WeatherDataModel()
    
   
    @IBOutlet weak var weatherCondition: UILabel!
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
  
        weatherTableView.dataSource = self
        
        weatherTableView.register(UINib(nibName: "cellDesgin", bundle: nil), forCellReuseIdentifier: "cellDesignWeather")
        
      
        
    }
    
    
    
    
    
    // This for animated view but i change it because some problems in virual machine
    /*
   // func animateViewUp()
   // {
     //    print("iwork")
   //     hightConstrains.constant = 250
        
     //   locationsHight.constant = 667 - 250
        
       
      //  UIView.animate(withDuration: 0.3) {
       //     self.view.layoutIfNeeded()
       // }
   // }*/
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDesignWeather", for: indexPath) as! cellDesgin
    
        cell.latTextLabel.text = locationsContainerlat[indexPath.row]
      
        cell.lonTextLabel.text = locationsContainerlon[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
     //   animateViewUp()
        
        
        let params :[String : String] = ["lat" : locationsContainerlat[indexPath.row], "lon" : locationsContainerlon[indexPath.row],"appid": AppID]
        
        
        
        getWeatherData(url: weatherURL, parameters: params)
        
        
    }
    
    
    
    

    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print ("Success Connection")
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                
                self.cityLabel.text = "Connection Issues"
                print ("Error:\(response.result.error)")
            }
        }
        
    }
    
    
    
    func updateWeatherData (json: JSON)
    {
        
        if  let tempResult = json["main"]["temp"].double {
        
        weatherDataMode.temprature = Int(tempResult - 273.15)
        
        weatherDataMode.city = json["name"].stringValue
        
        weatherDataMode.conition = json["weather"][0]["id"].intValue
        
        weatherDataMode.status = weatherDataMode.updateWeatherIcon(condition: weatherDataMode.conition)
        
            
        updateUIWeatherData()
            
            
        }
        
    }

    
    
    
    
    func updateUIWeatherData ()
    {
        
        cityLabel.text = weatherDataMode.city
        
        tempratureLabel.text = String (weatherDataMode.temprature)
        
        weatherCondition.text = weatherDataMode.status
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsContainerlat.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete { locationsContainerlon.remove(at: indexPath.row)
            locationsContainerlat.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
   
    
    
    
    
    @IBAction func exitButton(_ sender: Any) {
        
        exit(0)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.receivedLocations(locationsContainerUpdate: locationsContainer, lat: locationsContainerlat ,lon: locationsContainerlon)
        
        dismiss(animated: true, completion: nil)
    }
    
    


}
