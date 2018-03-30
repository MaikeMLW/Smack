//
//  Constants.swift
//  Smack
//
//  Created by Maike Warner on 12/28/17.
//  Copyright © 2017 Maike. All rights reserved.
//
//  typealias is simly renaming a type
//  example : typealias Johny = String
//            let name: Johny = "Johny"
// _ Success: Bool) -> () this is a custom closure - it's a first class function that can be passed around in code - how we gonna use it: we gonna send a webrequest - once that webrequest is done, we are going to say completed and pass into that closure true or false - and then we can do a check on that to see if that webrequest was succesful or not.

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://smackmychat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3631127477, green: 0.4045833051, blue: 0.8775706887, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")

//Segues
//Generally they use caps for constants
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
  "Content-Type": "application/json; charset=utf-8"
]

// header - key is Authorization and the value: Bearer, after the space comes the auth token. Now we have our body and header.
let BEARER_HEADER = [
  "Authorization":"Bearer \(AuthService.instance.authToken)",
  "Content-Type": "application/json; charset=utf-8"
]



