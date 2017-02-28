//
//  SettingsViewController.swift
//  tip
//
//  Created by Appel, Jeremy D on 2/19/17.
//  Copyright © 2017 JDA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let val = defaults.float(forKey: "defaultTip")
        setTipLabel(val)
        sliderControl.value = val
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setDefault(_ sender: Any) {
        let defaults = UserDefaults.standard
        let percentage = trunc(sliderControl.value)
        defaults.set(percentage, forKey: "defaultTip")
        setTipLabel(percentage)
        defaults.synchronize()
    }
    
    private func setTipLabel(_ val: Float) {
        tipPercentageLabel.text = String(format: "%.0f", val) + "%"
    }
}
