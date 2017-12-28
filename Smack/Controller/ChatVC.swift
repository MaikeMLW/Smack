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
  
    override func viewDidLoad() {
        super.viewDidLoad()
      menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
      
    }
  
}


