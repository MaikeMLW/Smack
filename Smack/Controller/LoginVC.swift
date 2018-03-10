//
//  LoginVC.swift
//  Smack
//
//  Created by Maike Warner on 12/28/17.
//  Copyright © 2017 Maike. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  // Outlets

  @IBOutlet weak var usernameTxt: UITextField!
  @IBOutlet weak var passwordTxt: UITextField!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    
    

        // Do any additional setup after loading the view.
    }

  
  @IBAction func loginPressed(_ sender: Any) {
    spinner.isHidden = false
    spinner.startAnimating()
    
    // unwrap our username and password - + check if we don't have an empty string
    guard let email = usernameTxt.text, usernameTxt.text != "" else { return }
    guard let pass = passwordTxt.text, passwordTxt.text != "" else { return }
    
    // then call off our login function - succes?
    // then we gonna use our brand new function -> find user by email
    // sending out our post noitifcation to let everybody know, that we have logged in - that the userData has changed.
    AuthService.instance.loginUser(email: email, password: pass) { (succes) in
      if succes {
        AuthService.instance.findUserByEmail(completion: { (succes) in
          if succes {
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            self.dismiss(animated: true, completion: nil)
          }
        })
        
      }
    }
    
  }
  
  @IBAction func closePressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func createAccntBtnPressed(_ sender: Any) {
    
    performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
  }
  
  // change the placeholder of the textfields username / password
  // hide the spinner
  func setUpView() {
    spinner.isHidden = true
    usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    
    passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
  }
  
}
