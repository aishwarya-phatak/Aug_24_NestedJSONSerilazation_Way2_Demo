//
//  ViewController.swift
//  Aug_24_NestedJSONSerilazation_Way2_Demo
//
//  Created by Vishal Jagtap on 29/10/24.
//

import UIKit

class ViewController: UIViewController {

    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        jsonParsing()
    }
    
    func jsonParsing(){
        url = URL(string: "https://dummyapi.online/api/users")
        
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for eachUserObject in jsonResponse{
                let eachUser = eachUserObject
                
                let eachUserId = eachUser["id"] as! Int
                let eachUserName = eachUser["name"] as! String
                let eachUseruserName = eachUser["username"] as! String
                let eachEmail = eachUser["email"] as! String
                
                let eachAddress = eachUser["address"] as! [String:Any]          //address key 
                
                let eachstreet = eachAddress["street"] as! String
                let eachCity = eachAddress["city"] as! String
                let eachState = eachAddress["state"] as! String
                let eachZipCode = eachAddress["zipcode"] as! String
                
                
                self.users.append(User(id: eachUserId, name: eachUserName,
                                       username: eachUseruserName, email: eachEmail,
                                       street: eachstreet, city: eachCity,
                                       state: eachState, zipcode: eachZipCode))
            }
            
            print(self.users)
        })
        dataTask?.resume()
    }
}
