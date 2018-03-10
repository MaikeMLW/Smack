//
//  MessageService.swift
//  Smack
//
//  Created by Maike Warner on 1/29/18.
//  Copyright © 2018 Maike. All rights reserved.
//
// this service is gonna be responsible for storage, our messages and channels, and also the functions that will retrieve messages and channels as well as utilities that is needed for this.
// we have now a place to store our channels.
// we need also a function to retrieve those - we need a authorization header and our urls.
// create our function going to have our web request and go and hit the api and bring back oall our channels back

//        do {  // using Json decoder - this is all the Json parsing you will need. It takes your channel model and just cramps everything that comes from the Json decodes it and stuffes it right into whatever variables you have in the message service or in your channel model as long as it matches correctly.
//          self.channels = try JSONDecoder().decode([Channel].self, from: data)
//        } catch let error {
//            debugPrint(Error as Any)
//        }
//        print(self.channels)

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
  
  static let instance = MessageService()  // singleton ?
  
  var channels = [Channel]()
  var selectedChannel : Channel?    // variable for the selected channels - which ever channel that we currently selected we gonna store that here. It's gonna be an optional, because if we are not logged in, then we don't have a selected channel.
  func findAllChannel(completion: @escaping CompletionHandler) {  // is a get request - we don't have to pass anything into the body ??
    Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in //http
    
      // gives us an array of JSON objects
      if response.result.error == nil {
        guard let data = response.data else { return }
        debugPrint(String(data: data, encoding: String.Encoding.utf8)!) //
        if let json = (try? JSON(data: data))?.array {
          for item in json {
            let name = item["name"].stringValue
            let channelDescription = item["description"].stringValue
            let id = item["_id"].stringValue   // with these 3 variables we can instanciate and create a new channel object. We are extract the properties we need and then we are going to initialize a new channel object from the struct initializer - and then we are going to add this new channel to our channel array that we store inside our message service.
            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
            self.channels.append(channel)
          }
          // This is how we do JSON parsing up until now. In swift4 there is a new way. They have new decodeble protocols.
          if self.channels.count > 0 {
            print(self.channels[0].channelTitle)
          } else {
            print("It's empty, bummer")
          }
          completion(true)
        }
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
  
  func clearChannels () {
    channels.removeAll()
  }
  
}
