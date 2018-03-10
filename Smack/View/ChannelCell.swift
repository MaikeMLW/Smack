//
//  ChannelCell.swift
//  Smack
//
//  Created by Maike Warner on 1/29/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
  
  // Outlets
  @IBOutlet weak var channelName: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
          self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
  
        } else { // if it is not selected
          self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
  
  func configureCell(channel: Channel) {  // we gonna pass in this function a channel object
     let title = channel.channelTitle ?? "" // nocolessing to say if you cannot find the value there then return it to an empty string.
    channelName.text = "#\(title)"
  }
  
}
