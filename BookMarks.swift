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
    
   @IBOutlet weak var hightConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    
    @IBOutlet weak var locationsHight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
  
        weatherTableView.dataSource = self
        
        weatherTableView.register(UINib(nibName: "cellDesgin", bundle: nil), forCellReuseIdentifier: "cellDesignWeather")
        
        // label2.text = locationsContainer[0]
        print (locationsContainer)
        // Do any additional setup after loading the view.
    }
    
    
   // func animateViewUp()
   // {
     //    print("iwork")
   //     hightConstrains.constant = 250
        
     //   locationsHight.constant = 667 - 250
        
       
      //  UIView.animate(withDuration: 0.3) {
       //     self.view.layoutIfNeeded()
       // }
   // }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDesignWeather", for: indexPath) as! cellDesgin
    
        cell.latTextLabel.text = locationsContainerlat[indexPath.row]
      
        cell.lonTextLabel.text = locationsContainerlon[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print (indexPath.row)
     //   animateViewUp()
        
        //let's get weather and using ApI
        
        let params :[String : String] = ["lat" : locationsContainerlat[indexPath.row], "lon" : locationsContainerlon[indexPath.row],"appid": AppID]
    }
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsContainerlat.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func deleteButton(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.receivedLocations(locationsContainerUpdate: locationsContainer, lat: locationsContainerlat ,lon: locationsContainerlon)
        
        dismiss(animated: true, completion: nil)
    }
    
    


}
