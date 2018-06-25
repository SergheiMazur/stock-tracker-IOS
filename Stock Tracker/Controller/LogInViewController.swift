//
//  LogInViewController.swift
//  Stock Tracker
//
//  Created by Serghei Mazur on 2018-06-23.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        let url = "https://stock-trackers.herokuapp.com/api/sessions"
        let userCredentials = ["email":emailTextField.text!,"password":passwordTextField.text!]
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        loginRequest(url: url, parameters: userCredentials, headers: headers)
    }
    
    func loginRequest(url: String, parameters:[String : String], headers:[String : String]) {
        Alamofire.request(url, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON {
                            response in
                            if response.result.description == "SUCCESS" {
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                guard let result = try? decoder.decode(DataUserCredentials.self, from: response.data!) else {
                                    print("Error: Couldn't decode data")
                                    return
                                }
                                
                                print(result)
                                
                                // MARK: UserDefaults - only for testing !!!
                                // TODO: Need to add Keychain access
                                UserDefaults.standard.set(result.data.user.email, forKey: "email")
                                UserDefaults.standard.set(result.data.user.authenticationToken, forKey: "token")
                                
                                self.performSegue(withIdentifier: "goToUserStocksFromLogin", sender: self)
                            } else if response.result.description == "FAILURE" {
                                self.showAlert(title: "Error", message: "Invalid Email or password.")
                            } else {
                                self.showAlert(title: "Error", message: "Please try again later")
                            }
        }
    }
    
    struct Credentials: Decodable {
        let authenticationToken : String
        let email : String
    }
    
    struct UserCredentials: Decodable {
        let user :Credentials
    }
    
    struct DataUserCredentials: Decodable {
        let data :UserCredentials
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
    
}
