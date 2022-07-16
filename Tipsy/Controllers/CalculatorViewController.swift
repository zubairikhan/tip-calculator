//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    let tips = ["0%": 0.0, "10%": 10.0, "20%": 20.0]
    var tipAmount = 10.0
    var splitNumber: Int = 2
    var splitAmount: Double = 0.0

    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        tipAmount = tips[(sender.titleLabel?.text)!] ?? 0.0
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        splitNumber = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print(tipAmount)
        print(splitNumber)
        let billAmount: Double = Double((billTextField.text)!) ?? 0.0
        splitAmount = (billAmount + billAmount * (tipAmount/100)) / Double(splitNumber)
        print()
        
        self.performSegue(withIdentifier: "CalculatorToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CalculatorToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.splitNumber = splitNumber
            destinationVC.splitAmount = splitAmount
            destinationVC.tip = tipAmount
        }
    }
}

