//
//  CircleImage.swift
//  Smack
//
//  Created by Maike Warner on 1/5/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

// what this subclass is gonna do - make everything which applied to a circle.
// so we can see the results inside the storyboard
// when we awakeFromNib or prepareForInterfaceBuilder we call setupView in which we simply do a full rounding of the imageView, based on it's width.
@IBDesignable
class CircleImage: UIImageView {

  override func awakeFromNib() {
    setupView()
  }
  
  // we gave it a cornier radius of half it widht, asuming that it's a square - then it's gonna be a perfect circle.
  func setupView() {
    self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
    
  
  }
  
}
