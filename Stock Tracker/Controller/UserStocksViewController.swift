//
//  UserStocksViewController.swift
//  Stock Tracker
//
//  Created by Serghei Mazur on 2018-06-23.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserStocksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    // MARK: UserDefaults - only for testing !!!
    // TODO: Need to add Keychain access
    private let email = UserDefaults.standard.string(forKey: "email")
    private let token = UserDefaults.standard.string(forKey: "token")
    
    
    private var stocks: [UserStocksData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutBarButton.target = self
        logoutBarButton.action = #selector(self.logoutPressed)
    
    
        
        let url = "https://stock-trackers.herokuapp.com/api/user_stocks"
        var headers = ["Content-Type": "application/json", "Accept": "application/json"]
        if (email != nil) && (token != nil) {
            headers["X-User-Token"] = token!
            headers["X-User-Email"] = email!
        }
        
        userStocksRequest(url: url, headers: headers)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stocks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     cell.textLabel?.text = stocks[indexPath.row].createdAt
     return cell
     }
 
    
    func userStocksRequest(url: String, headers:[String : String]) {
        Alamofire.request(url, method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON {
                            response in
                            if response.result.description == "SUCCESS" {
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                guard let result = try? decoder.decode([UserStocksData].self, from: response.data!) else {
                                    print("Error: Couldn't decode data")
                                    return
                                }
                                
                                self.stocks = result
                                print(self.stocks)
                                self.tableView.reloadData()
                                
                                
                            } else if response.result.description == "FAILURE" {
                                self.showAlert(title: "Error", message: "Invalid data")
                            } else {
                                self.showAlert(title: "Error", message: "Please try again later")
                            }
        }
    }
    
    struct UserStocksData: Decodable {
        let createdAt : String
        let updatedAt : String
        let id : Int
        let stockId : Int
        let userId : Int
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func logoutPressed() {
        let userDef = UserDefaults.standard
        userDef.removeObject(forKey:"email")
        userDef.removeObject(forKey:"token")
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ViewController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
