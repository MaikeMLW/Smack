//
//  ProfileVC.swift
//  Smack
//
//  Created by Maike Warner on 1/13/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

  
  // Outlets
  
  @IBOutlet weak var profileImg: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userEmail: UILabel!
  
  @IBOutlet weak var bgView: UIView!
  // We gonna add a gesture recognizer - that when someone clicks on it will also dismiss. 
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupView()

        // Do any additional setup after loading the view.
    }
  
  
  @IBAction func logoutPressed(_ sender: Any) {
    UserDataService.instance.logoutUser()
    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    dismiss(animated: true, completion: nil)
    
    // when we logged out, we created that notification to notify other classes when userdata changes. And this is a prime example of userdata is changed. We have cleaned everything.
    // When we looged out, we gonna clear the channels, clear the chats - just cleaning - that why we need this notification post.
  }
  
  @IBAction func closeModalPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil) // ?
  }
  
  // Showing up!! Ask
  func setupView() {
    userName.text = UserDataService.instance.name
    userEmail.text = UserDataService.instance.email
    profileImg.image = UIImage(named: UserDataService.instance.name)  //?
    profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    
    // add a gesture recognizer to the backgroundView - you could tap on it and it would dismiss as well.
    let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_recognizer:)))  //???
    bgView.addGestureRecognizer(closeTouch)
    
  }
  
  // create a function for the target above
  @objc func closeTap(_recognizer:UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
    
  }
  
}



