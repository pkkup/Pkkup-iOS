//
//  SettingsViewController.swift
//  Pkkup
//
//  Created by Jonathan Tsai on 10/6/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class SettingsViewController: PkkupViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var cityFiled: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var favSportField: UITextField!
    @IBOutlet weak var biographyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = _THEME_COLOR
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true);
    }

    @IBAction func onSubmitButton(sender: AnyObject) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
