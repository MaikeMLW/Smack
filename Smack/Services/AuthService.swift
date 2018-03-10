//
//  AuthService.swift
//  Smack
//
//  Created by Maike Warner on 12/29/17.
//  Copyright © 2017 Maike. All rights reserved.
//
//this is gonna be a singleton - which means this is gonna be accessible  globally. There can only be one instance at the time.

import Foundation
import Alamofire
import SwiftyJSON


class AuthService {
  
  static let instance = AuthService()
  
  let defaults = UserDefaults.standard
  
  // get-> see if the value exist
  var isLoggedIn : Bool {
    get {
      return defaults.bool(forKey: LOGGED_IN_KEY)
    }
    set {
      defaults.set(newValue, forKey: LOGGED_IN_KEY)
    }
  }
  //we have to cast it as a string
  var authToken: String {
    get {
      return defaults.value(forKey: TOKEN_KEY) as! String
    }
    set {
      defaults.set(newValue, forKey: TOKEN_KEY)
    }
  }
  
  var userEmail: String {
    get {
      return defaults.value(forKey: USER_EMAIL) as! String
    }
    set {
      defaults.set(newValue, forKey: USER_EMAIL)
    }
  }

//Create a webrequest - specify the headers, the body, specify how we want to see the response come back etc. We gonna use alamofire
//Alamofire is a libary on top off url session framework that makes webrequest a lot easier.
//we send a webrequest, but we never know when the response comes back - we have to know when it's finished - we do this with a completion handler.
// @escaping is a keyword what we need for our completion.
  
  
  func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
  
    let lowerCaseEmail = email.lowercased()
    
    let body: [String: Any] = [
      "email": lowerCaseEmail,
      "password": password
    ]
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
      
      if response.result.error == nil {
         completion(true)
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
        
      }
    }
  }
  
  func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
    
    let lowerCaseEmail = email.lowercased()
    
    let body: [String: Any] = [
      "email": lowerCaseEmail,
      "password": password
    ]
    
    //       if let json = response.result.value as? Dictionary<String, Any> {
    //       if let email = json["user"] as? String {
    //          self.userEmail = email
    //         }
    
    //         if let token = json["token"] as? String {
    //         self.authToken = token
    //       }
    //     }
    
    // Using SwiftyJSON
    
    Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {(response) in
      
      if response.result.error == nil {

        guard let data = response.data else { return }
        let json = try! JSON(data: data)
        self.userEmail = json["user"].stringValue
        self.authToken = json["token"].stringValue
        
        self.isLoggedIn = true
        completion(true)
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
      
    }

  }
  
  // code up this add user function
  func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
    
    let lowerCaseEmail = email.lowercased()
    
    let body: [String: Any] = [
      "name": name,
      "email": lowerCaseEmail,
      "avatarName": avatarName,
      "avatarColor": avatarColor,
      
    ]
    
    //responsetype is json because we want the response at the http request return to us in the form of json
    Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
    
      
    // Just like we did with our register of loginUser - get back some data - and turn that data into a json object and then parse it out from there.
      // create some variable that we can
      if response.result.error == nil {
        guard let data = response.data else { return}
        self.setUserInfo(data: data)
        completion(true)
        
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
      
    }
    
  }
        // if the response error is nil, we are gonna extract the data from response - than we gonna pass that data the data to the function setUserInfo - which is essentially the same thing that we did in our create user function, in which we extract the id, color, avartarName etc. pass those into the function in our UserDataService.
  
  func findUserByEmail(completion: @escaping CompletionHandler){
    
    Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {(response) in
      
      if response.result.error == nil {
        guard let data = response.data else { return}
        self.setUserInfo(data: data)
        completion(true)
        
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    // create our url - we need a bearer? header
    }
  }

  func setUserInfo(data: Data) {
    let json = try! JSON(data: data)
    let id = json["_id"].stringValue
    let color = json["avatarColor"].stringValue
    let avatarName = json["avatarName"].stringValue
    let email = json["email"].stringValue
    let name = json["name"].stringValue
    
    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
  }
  
  
  
}

