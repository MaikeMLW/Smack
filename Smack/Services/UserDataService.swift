//
//  UserDataService.swift
//  Smack
//
//  Created by Maike Warner on 1/3/18.
//  Copyright © 2018 Maike. All rights reserved.
//
//  When we logged in we set a whole bunch of variables and booleans.

import Foundation

class UserDataService {
  
  static let instance = UserDataService()
  
  public private(set) var id = ""
  public private(set) var avatarColor = ""
  public private(set) var avatarName = ""
  public private(set) var email = ""
  public private(set) var name = ""
  
  func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
    self.id = id
    self.avatarColor = color
    self.avatarName = avatarName
    self.email = email
    self.name = name
    
  }
  // func to update the avatarName
  func setAvatarName(avatarName: String) {
    self.avatarName = avatarName
  
  }
  
  //     "[0.901960784313726, 0.364705882352941, 0.819607843137255, 1]", - extract from this string, each of these values into rgb and a.
  // gonna introduce a sort of scanner - An abstract superclass of a class cluster that scans values from a string. - An NSScanner object interprets and converts the characters of an NSString object into number and string values.
  // we gonna start from the beginning, scan throught it and can have specific rules, and have it do something for us.
  // tell which characters to skip and not care about
  // method comma - say: start at the beginning and upto a specific character - stop at the comma.
  // create a few variables and save our RGB values into - create muliple variables on the same line as long they are the same type.
  // scan upto the comma, skip the brackets - then i save this variable into r.
  func returnUIColor(components: String) -> UIColor {
    let scanner = Scanner(string: components)
    let skipped = CharacterSet(charactersIn: "[], ")
    let comma = CharacterSet(charactersIn: ",")
    scanner.charactersToBeSkipped = skipped
    
    var r, g, b, a : NSString?
    
    scanner.scanUpToCharacters(from: comma, into: &r)
    scanner.scanUpToCharacters(from: comma, into: &g)
    scanner.scanUpToCharacters(from: comma, into: &b)
    scanner.scanUpToCharacters(from: comma, into: &a)
    
    // we gonna need a default color
    let defaultColor = UIColor.lightGray
    
    // if anything of the unwrapping gonna fail, then it's going to the default color.
    // an unwrapped string for each of these variables
    guard let rUnwrapped = r else { return defaultColor }
    guard let gUnwrapped = g else { return defaultColor }
    guard let bUnwrapped = b else { return defaultColor }
    guard let aUnwrapped = a else { return defaultColor }
    
    //  - But we need them in a CGFloat - how to convert this string in a CGFloat
    // There is not a direct version between strings to CGFloat- there is a conversion from string to doublevalue, and from there we can do from doublevalue to CGFloat
    let rFloat = CGFloat(rUnwrapped.doubleValue)
    let gFloat = CGFloat(gUnwrapped.doubleValue)
    let bFloat = CGFloat(bUnwrapped.doubleValue)
    let aFloat = CGFloat(aUnwrapped.doubleValue)
    
    let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
    
    
    return newUIColor
    
  }
  
  // Create a loggingout user function
  // set all the variables back to empty strings
  func logoutUser() {
    id = ""
    avatarName = ""
    avatarColor = ""
    email = ""
    name = ""
    AuthService.instance.isLoggedIn = false
    AuthService.instance.userEmail = ""
    AuthService.instance.authToken = ""
  // We also want to set the auth variables
    MessageService.instance.clearChannels()
    
    
    
    
  }
  
}
