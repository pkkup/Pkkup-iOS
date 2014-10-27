//
//  CreateGameViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class CreateGameViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var createGameButton: UIButton!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var gamePicker: UIPickerView!
    
    
    var locations: [PkkupLocation] = _LOCATIONS
    var games: [PkkupGame] = _GAMES

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationPicker.tag = 1
        gamePicker.tag = 2

        locationPicker.dataSource = self
        locationPicker.delegate = self
        gamePicker.dataSource = self
        gamePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCreateGame(sender: AnyObject) {
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
/*    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return locations[row].name
    }*/
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1) {
            return locations.count
        } else {
            return games.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1) {
            println("Location selected locName: \(locations[row].name!)")
        } else {
            println("Game selected lgameName: \((games[row].sport?.name!)!)")
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var label = UILabel(frame: CGRectMake(0, 0, locationPicker.frame.size.width, 50))
        label.backgroundColor = UIColor.lightGrayColor()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.preferredFontForTextStyle("HelveticaNeue-Bold")
        label.font.fontWithSize(12)
        if(pickerView.tag == 1) {
            label.text = locations[row].name
        } else {
            label.text = games[row].sport?.name
        }
        return label;
        
    }
}
