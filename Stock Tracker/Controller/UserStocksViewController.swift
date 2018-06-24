//
//  UserStocksViewController.swift
//  Stock Tracker
//
//  Created by Serghei Mazur on 2018-06-23.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class UserStocksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let tempArray = ["First","Second","Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     cell.textLabel?.text = tempArray[indexPath.row]
     return cell
     }
 


}
