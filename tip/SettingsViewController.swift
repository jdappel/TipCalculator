//
//  SettingsViewController.swift
//  tip
//
//  Created by Appel, Jeremy D on 2/19/17.
//  Copyright © 2017 JDA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    private let percentages = [0.18, 0.20, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let val = defaults.double(forKey: "defaultTip")
        let index = percentages.index(of: val) ?? 0
        tipControl.selectedSegmentIndex = index
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setDefault(_ sender: Any) {
        let percentages = [0.18, 0.20, 0.25]
        let defaults = UserDefaults.standard
        defaults.set(percentages[tipControl.selectedSegmentIndex], forKey: "defaultTip")
        defaults.synchronize()
    }

}
