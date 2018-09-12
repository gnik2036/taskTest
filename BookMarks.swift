//
//  BookMarks.swift
//  taskIOTBLUE
//
//  Created by shady on 9/12/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

class BookMarks: UIViewController {
    
  
    var locationsContainer = [String]()
  
    @IBOutlet weak var weatherTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
  //      weatherTableView.delegate = self
    //    weatherTableView.dataSource = self
	
        // label2.text = locationsContainer[0]
        print (locationsContainer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var label2: UILabel!
    
    


}
