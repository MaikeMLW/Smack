//
//  AddChannelVC.swift
//  Smack
//
//  Created by Maike Warner on 2/5/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

  // Outlets
  
  @IBOutlet weak var nameTxt: UITextField!
  
  @IBOutlet weak var chanDesc: UITextField!
  @IBOutlet weak var bgView: UIView!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    
    }
  
  // unwrapped variables for our channelName and channelDescription
  // after we created the model press the button and gonna dismiss it.
  
  @IBAction func createChannelPressed(_ sender: Any) {
    guard let channelName = nameTxt.text , nameTxt.text != "" else { return }
    guard let channelDesc = chanDesc.text else { return }
    SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (succes) in
      if succes {
        self.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func closeModalPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  // we are gonna set the placeholder, attributed fontcolor, create tap recognizer
  func setupView() {
    let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
    bgView.addGestureRecognizer(closeTouch)
    
    // add placeholder color
    nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
  }
  
  @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  
  }
  
  // func doStuff(thing: String) {
    
  // }
  // doStuff(thing:)
  
  //self.doStuff(thing: "herehwfiorhfwoirhf")
  
  // func otherStuff(_ thing: String) { leave the argumentname out of the function
    
  // }
  // otherStuff(_:)
  
  //self.otherStuff("sgihorwiegh")
}




