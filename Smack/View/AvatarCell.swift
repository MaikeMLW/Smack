//
//  AvatarCell.swift
//  Smack
//
//  Created by Maike Warner on 1/4/18.
//  Copyright © 2018 Maike. All rights reserved.
//
// We need to create a custom class for our cell

import UIKit

// We need to know if it's gonna be a dark or light cell
enum AvatarType {
  case dark
  case light
}

class AvatarCell: UICollectionViewCell {
  
  @IBOutlet weak var avatarImg: UIImageView!
  
  // set up our view and our functions what we are gonna be creating as well
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpView()
  }
// we need to know the index, so we set the image and we need to know the type of the avatar, whether it's dark or light - if it's a light avatar the background it's gonna be dark and when it's a dark avatar that the background it's gonna be lighter - so that the backgrounds accenturates the avatar images.
  func configureCell(index: Int, type: AvatarType) {
    if type == AvatarType.dark {
      avatarImg.image = UIImage(named: "dark\(index)")
      self.layer.backgroundColor = UIColor.lightGray.cgColor
    } else {
      avatarImg.image = UIImage(named: "light\(index)")
      self.layer.backgroundColor = UIColor.gray.cgColor
    }
  }
  
  
  
  func setUpView() {
    self.layer.backgroundColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
  }
  
}
