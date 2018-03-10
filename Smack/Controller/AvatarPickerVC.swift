//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Maike Warner on 1/3/18.
//  Copyright © 2018 Maike. All rights reserved.
//

import UIKit

   // We need to work with our colletionView, so we need to implement our protocols.
class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


   // Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  // Variables - We need to create variables that stores the type of avatartype what we are currently selected. Set by default.
  var avatarType = AvatarType.dark
  
  // We need to set up aour setup and datasource
  override func viewDidLoad() {
        super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self

    }
  // We need to call our configur cell function
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
         cell.configureCell(index: indexPath.item, type: avatarType)
        return cell
    }
    return AvatarCell()
  }
  
  // We need to know how many sections we have
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Need to know how many items are in the sections
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 28
  }
// check which segment control is selected - and then you need to change the avatarType - and then you need to do something to reload the data
  // with selectedSegmentIndex is how we select and know which one
  @IBAction func segmentControlChanged(_ sender: Any) {
    if segmentControl.selectedSegmentIndex == 0 {
      avatarType = .dark
    } else {
      avatarType = .light
    }
    collectionView.reloadData()
  }
  
  // math and coding to make it more fluid - screensizes - sizes of the cells and columns to be dynamic, based on which sreensize we are using. Calculate the number of coloums and the size of the individual cells based on the screensize.
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var numOfColumns : CGFloat = 3
    if UIScreen.main.bounds.width > 320 {  //widht of the current screen
      numOfColumns = 4 // if it's bigger than we go with 4 colums
      
    }
    
    // goal is to calculate how tall and how wide we want each of cell to be - based on screenwidth - we want to know the gab between the cells - and we also need to know the inset distance which is the padding on the side (to be equal to 20)
    // now we need to calculate the size (height and width) of the cells.
    // basically eliminating everything what is not a collectionView cell
    let spaceBetweenCells : CGFloat = 10
    let padding : CGFloat = 40 // because it's 20 on both sides
    let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
    return CGSize(width: cellDimension, height: cellDimension)
    
  }
  
  // select an avatar
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if avatarType == .dark {
      UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
    } else {
      UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
    }
    self.dismiss(animated: true, completion: nil)
    
  }
  
  
  @IBAction func backPressed(_ sender: Any) {
  dismiss(animated: true, completion: nil)
  }

 }

