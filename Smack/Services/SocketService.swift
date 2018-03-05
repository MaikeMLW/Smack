//
//  SocketService.swift
//  Smack
//
//  Created by Maike Warner on 2/24/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
  
  static let instance = SocketService()
  
  override init() {
    super.init()
    
  }
  
  var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
  
  // We are creating a socket and we are pointing it to our api url
  
  func establishConnection() {
    socket.connect()
  }
  
  func closeConnection() {
    socket.connect()
  }
  
  func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler ) {
    socket.emit("newChannel", channelName, channelDescription)
    completion(true)
    
  }
  
  func getChannel(completion: @escaping CompletionHandler) {
    socket.on("channelCreated") { (dataArray, ack) in
      guard let channelName = dataArray[0] as? String else { return}
      guard let channelDesc = dataArray[1] as? String else { return}
      guard let channelId = dataArray[2] as? String else { return}
      
      let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
      
      MessageService.instance.channels.append(newChannel)
      completion(true)
    }
  }
  
  // ack = acknowlegdement
  
  // our app, we have an open connection between our app and the server API - so when we create a channel , so what we are doing then is sending an emit. When something is being send via websockets is called an emit, and it can be an emit from the app or the API. So if the app is sending something to the server, then it's performing an emit from the app to the server. If the server is sending out information, is performing an emit from the server out to how many apps are currently connected
  
  // create a function to add a channel
  // We are handling addition of channels and messages via sockets. How that works is we have the connection between our app and server api - when we create a channel, we are sending an emit. When something is being send via websockets, that's called an emit. It can be an emit from the app or the API. So if the app is sending something to the server and it's performing an emit ... The way to receive information is called a 'Dot on'- and the other is socket.emit. That's the terminology with sending and receiving information, dealing with sockets.
  
  // when we are adding a channel, we are performing an emit from the app - and we send that channel to the API server. And then what happens is the API gets that information and it's create a channel object, saves it to the database and then immediately dispurses that channel back to our app and to as many app who are currently connected at that time. - So we need a couple functions now. We need a function to emit a channel object to the server - and we also need a function that what can detect when that channel comes back to us. Because we don't actually add the channel to our channels array in our message service untill we detect that coming back from the API and then we know that the edition of the channel has been succesful on the online datatbase.
  
  // How socketIO works is on socket events - so the server is listening or an event called 'newChannel' and then it's expecting a couple of parameters, being 'name' and 'description'. And then it creates a new Channel object from that information and saves it to the database. And then it's emits back to the any apps that are currently connected it's emits and send back that channel.
  
}






