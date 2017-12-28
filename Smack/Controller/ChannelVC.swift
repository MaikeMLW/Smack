//
//  ChannelVC.swift
//  Smack
//
//  Created by Maike Warner on 12/11/17.
//  Copyright © 2017 Maike. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
  
  //Outlets
  
  @IBOutlet weak var loginBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

  @IBAction func loginBtnPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_LOGIN, sender: nil)
  }
  
}
