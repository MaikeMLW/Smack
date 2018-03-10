//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Maike Warner on 12/28/17.
//  Copyright © 2017 Maike. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

  // Outlets
  @IBOutlet weak var usernameTxt: UITextField!
  @IBOutlet weak var emailTxt: UITextField!
  @IBOutlet weak var passTxt: UITextField!
  @IBOutlet weak var userImg: UIImageView!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  
  // Variables - gives a default light grey color.
  var avatarName = "profileDefault"
  var avatarColor = "[0.5, 0.5, 0.5. 1]"
  var bgColor :  UIColor?  // this is gonna be an optional
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
  
  // update user image, the one we just selected
  // we set the local variable name which we use in our create user function.
  // we have selected one from the avatar picker
  override func viewDidAppear(_ animated: Bool) {
    if UserDataService.instance.avatarName != "" {
      userImg.image = UIImage(named: UserDataService.instance.avatarName)
      avatarName = UserDataService.instance.avatarName
      if avatarName.contains("light") && bgColor == nil {
        userImg.backgroundColor = UIColor.lightGray   //if so
      }
      
    }
  }

  
  @IBAction func createAccntPressed(_ sender: Any) {
    spinner.isHidden = false
    spinner.startAnimating()
    
    guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
    guard let email = emailTxt.text , emailTxt.text != "" else { return }
    guard let pass = passTxt.text , passTxt.text != "" else {
      return}
    
    AuthService.instance.registerUser(email: email, password: pass) { (succes) in
      
      if succes {
        AuthService.instance.loginUser(email: email, password: pass, completion: { (succes) in
          if succes {
            AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
              if succes {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()  // we need self because we are in a closure.
                self.performSegue(withIdentifier: UNWIND, sender: nil)
                // We've come through the 3 stages; we registered a user, logged in and created an account - at that point we would dismiss the create account view and then go through the process of updating the UI etc.
                
                // After the create account is pressed and everything is succesful,we are going post this notification - basicly just sending out the notification - hey world, we have successfully logged in, logged out, or created a user,
                // create a reusable notification
                // this completes our accountVC
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                
                
            }
          })
         }
       })
     }
    }
  }

  @IBAction func pickAvatarPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
  }
  
  // create a randomly uicolor
  // create an upperbound
  // values for RGB (number between 1 and 255 / 255)
  // we gonna make a background color with these
  @IBAction func pickBGColorPressed(_ sender: Any) {
    let r = CGFloat(arc4random_uniform(255)) / 255
    let g = CGFloat(arc4random_uniform(255)) / 255
    let b = CGFloat(arc4random_uniform(255)) / 255
    
    bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    avatarColor = "[\(r), \(g), \(b), 1]"  // backgroundcolor on the front blue  page  -??
    UIView.animate(withDuration: 0.2) {
       self.userImg.backgroundColor = self.bgColor
    }
   
    
  }
  @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
  }
  
  // change blue color text in light grey. You cannot do this in UI - has to be done in code.
  // The styled string that is dislayed when there is no other text in the text field.
  func setupView() {
    spinner.isHidden = true
    usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    
    emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    
    passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    
    // fix the problem where we can't create account button when the keyboard is up. We are used to tap off the keyboard and make the keyboard disapear. We going to add a tap recognizer to solve this problem.
    // now we need just to assign it to the view
    let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
    view.addGestureRecognizer(tap)
    
  }
  

  
  // first create a function for in the action tapGestureRecognizer
  // Causes the view (or one of its embedded text fields) to resign the first responder status - means: if we have a keyboard open and we tap, then it's just going to dismiss that keyboard for us.
  @objc func handleTap() {
   view.endEditing(true)
    
    
  }
  
 }




