//
//  ViewController.swift
//  Stock Tracker
//
//  Created by Serghei Mazur on 2018-06-21.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If there is a logged in user, by pass this screen and go straight to UserStocksController
        if (UserDefaults.standard.string(forKey: "token") != nil) && (UserDefaults.standard.string(forKey: "email") != nil) {
            performSegue(withIdentifier: "goToUserStocks", sender: self)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

