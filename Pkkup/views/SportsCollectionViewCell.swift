//
//  SportsCollectionViewCell.swift
//  Pkkup
//
//  Created by Deepak on 10/9/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

protocol SportsCellDelegate {
    func sportWasSelected(sportCell: SportsCollectionViewCell, selectedSport: String) -> Void
}

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportButton: UIButton!
    @IBOutlet weak var buttonSelectedView: UIView!
    var delegate: SportsCellDelegate?
    /*
    var pkkupSport: PkkupSport {
        didSet(newSport) {
            sportButton.setTitle(pkkupSport.name, forState: UIControlState.Normal)
        }
    }*/
    
    @IBAction func didSelect(sender: UIButton) {
        NSLog("Button was Selected \(sender.currentTitle!)")
        self.buttonSelectedView.backgroundColor = UIColor.orangeColor()
        delegate?.sportWasSelected(self, selectedSport: sender.currentTitle!)
        //We have to clearOtherCells colors
        //I think, we have to use delegate
        
        //We have to reload the Table, if the selection has changed
    }
    
}
