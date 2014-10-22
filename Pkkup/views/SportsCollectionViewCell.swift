//
//  SportsCollectionViewCell.swift
//  Pkkup
//
//  Created by Deepak on 10/9/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

protocol SportsCellDelegate {
    func sportWasSelected(sportCell: SportsCollectionViewCell, sportName: String) -> Void
}

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var sportButton: UIButton!
    @IBOutlet weak private var buttonSelectedView: UIView!

    var delegate: SportsCellDelegate?

    var sport: PkkupSport! {
        willSet(newSport) {
            sportButton.setTitle(newSport.name, forState: UIControlState.Normal)
            if newSport.isSelected != nil && newSport.isSelected! {
                buttonSelectedView.backgroundColor = UIColor.orangeColor()
            } else {
                buttonSelectedView.backgroundColor = UIColor.clearColor()
            }
        }

        didSet(oldSport) {
        }
    }
    
    @IBAction func didSelect(sender: UIButton) {
        NSLog("Button was Selected \(sender.currentTitle!)")
        if(self.buttonSelectedView.backgroundColor == UIColor.orangeColor()) {
            self.buttonSelectedView.backgroundColor = UIColor.clearColor()
        } else {
            self.buttonSelectedView.backgroundColor = UIColor.orangeColor()
        }
        delegate?.sportWasSelected(self, sportName: sender.currentTitle!)
    }
    
}
