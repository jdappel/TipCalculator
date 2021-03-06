//
//  ViewController.swift
//  tip
//
//  Created by Appel, Jeremy D on 2/14/17.
//  Copyright © 2017 JDA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    var formatter : NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: Locale.current.identifier)
        return f
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.placeholder = getCurrencySymbol()
        
        loadDefaults()
        calculateTip()
    }
    
    private func getCurrencySymbol() -> String {
        return Locale.current.currencySymbol ?? "$"
    }
    
    private func loadDefaults() {
        
        let defaults = UserDefaults.standard
        let val = defaults.float(forKey: "defaultTip")
        let timeStamp = defaults.object(forKey: "timestamp") ?? Calendar.current.date(byAdding: .minute, value: -10, to: Date())
        if (lessThan10Minutes(date: timeStamp as! Date)) {
            if let bill = defaults.string(forKey: "bill") {
                billField.text = bill
            }
            else {
                billField.becomeFirstResponder()
            }
        }
        else {
            billField.becomeFirstResponder()
        }
        
        sliderControl.value = val
        setTipLabel(val)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadDefaults()
        calculateTip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        calculateTip()
    }
    
    private func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * (Double(trunc(sliderControl.value)) / 100)
        let total = bill + tip
        setTipLabel(sliderControl.value)
        
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
        save()
    }
    
    private func setTipLabel(_ val: Float) {
        tipPercentageLabel.text = String(format: "%.0f", val) + "%"
    }
    
    private func save() {
        let savedTime = Date()
        
        let defaults = UserDefaults.standard
        defaults.set(savedTime, forKey: "timestamp")
        defaults.set(billField.text!, forKey: "bill")
        defaults.synchronize()
    }
    
    private func lessThan10Minutes(date: Date) -> Bool {
        let now = Date()
        let minutesSinceDate = Calendar.current.dateComponents([.minute], from: date, to: now).minute ?? 0
        return minutesSinceDate < 10
    }
}

