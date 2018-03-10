//
//  ChannelVC.swift
//  Smack
//
//  Created by Maike Warner on 12/11/17.
//  Copyright © 2017 Maike. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  //Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var userImg: CircleImage!
  @IBOutlet weak var loginBtn: UIButton!
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

      self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
      
      // Changed our ChannelVC, based on whether we are loggin in. Add an observer in viewDidLoad what listens to that notification
      NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
      
      SocketService.instance.getChannel { (succes) in
        if succes {
          self.tableView.reloadData()
        }
      }
    }
  // we need to do a check and setting the user data accordingly. Everything what's done in userDataDidChange we need to do here.
  override func viewDidAppear(_ animated: Bool) {
    setupUserInfo()
  }


  @IBAction func addChannelPressed(_ sender: Any) {
    if AuthService.instance.isLoggedIn {
      let addChannel = AddChannelVC()  // instantiate viewcontroller
      addChannel.modalPresentationStyle = .custom   // set model presentation style
      present(addChannel, animated: true, completion: nil)
    }
  
  }
  
  @IBAction func loginBtnPressed(_ sender: Any) {
    if AuthService.instance.isLoggedIn{
      // Show profile page
      let profile = ProfileVC()
      profile.modalPresentationStyle = .custom
      present(profile, animated: true, completion: nil)
    }else{
      performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
  }
  
  // create a function what has to be in the selector
  // accepting a notif and notification here
  // have to expose it to the obj-C
  // everytime when we receive that notification
  // we want to update the UI
  // if we are logged in we gonna change the button
  // change user image
  // if we are logged in when we set the user image - now we can set the background color as well.
  @objc func userDataDidChange(_ notif: Notification) {
  // cut the code and put it under setupUserInfo
    setupUserInfo()
  }
  
  func setupUserInfo () {
    if AuthService.instance.isLoggedIn {
      loginBtn.setTitle(UserDataService.instance.name, for: .normal)
      userImg.image = UIImage(named: UserDataService.instance.avatarName)
      userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)  // ?
    } else {  // if we are not logged in - or when we are logged out
      loginBtn.setTitle("Login", for: .normal)
      userImg.image = UIImage (named: "menuProfileIcon")  // userImage back to default
      userImg.backgroundColor = UIColor.clear  // then set backgroundColor to clear
      tableView.reloadData() // the flow is we press logout and that triggers a userDataDidChange - so when we click logout, we have set the isLoggedIn bool into false. It will reload will all empty.
    }
}

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {      // we gonna cast that as
      
      // create a variable for the channel we want to pass into it. Channel comes from message service - array of channels.
      let channel = MessageService.instance.channels[indexPath.row]
      cell.configureCell(channel: channel)
      return cell
    } else {
      return UITableViewCell() // return empty TVC
    }
  
  }
  
  // now we need to know how many rows and how many sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageService.instance.channels.count    // how many channels there are in the message service.
  }
}







