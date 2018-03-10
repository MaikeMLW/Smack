//
//  RoundedButton.swift
//  Smack
//
//  Created by Maike Warner on 1/2/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat = 3.0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  override func awakeFromNib() {
    self.setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.setupView()
  }
  
  func setupView() {
    self.layer.cornerRadius = cornerRadius
    
  }
}






