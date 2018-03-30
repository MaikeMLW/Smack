//
//  ChatVC.swift
//  Smack
//
//  Created by Maike Warner on 12/11/17.
//  Copyright © 2017 Maike. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

  //Outlets
  
  @IBOutlet weak var menuBtn: UIButton!
  @IBOutlet weak var channelNameLbl: UILabel!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
      menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
      
      NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
      
      // check - if we are logged in then we gonna call that function user by email and do our post notification user data has changed - that should go to the right direction.
      // we have logged in, so user data has changed. Notification that we are posting notif_user_data_did_change
      if AuthService.instance.isLoggedIn {
        AuthService.instance.findUserByEmail(completion: { (succes) in
          NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        })
      }
    }
  
  @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
          onLoginGetMessages()
        // get channels
      } else {
      channelNameLbl.text = "Please Log In" // so after we logout
      }
  }
  // create selector for in the addObserver
  @objc func channelSelected(_ notif: Notification) {
    updateWithChannel()
  }
  // when we select a channel, that we update the text in the blue / replace the 'smack' word on top to the name of the channel.
  // So, if it cannot find a non optional string, then just set it equal to an empty string.
  func updateWithChannel() {
    let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
    channelNameLbl.text = "# \(channelName)"
    getMessages()
  }
  
  // So we login and we find all the channels, if there is at least one channel, then we set our selected channel equal to it. And then we gonna update the channel - then we call this updateWithChannel. So we gonna create a new function called getMessages
  func onLoginGetMessages() {
    MessageService.instance.findAllChannel { (success) in
      if success {
        if MessageService.instance.channels.count > 0 {
          MessageService.instance.selectedChannel = MessageService.instance.channels[0]
          self.updateWithChannel()
        } else {  // if there are no channels
          self.channelNameLbl.text = "No channels yet!"
        }
      }
    }
  }
  
  // To call a function we need a channel id, so first to unwrap the channelId
  func getMessages() {
    guard let channelId = MessageService.instance.selectedChannel?.id else { return }
    MessageService.instance.findAllMessageForChannel(channelId: channelId) { (succes) in

    }
  }
  
  
  
  
  
  
  
  
  
  
  
        // Do stuff with channels
        //once we login, the first thing we do is finding the channels.
      }


