//
//  SettingTableViewController.swift
//  TipCalculator
//
//  Created by GIRGEZ on 10/4/16.
//  Copyright © 2016 GIRGEZ. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    @IBOutlet weak var Symbol1Label: UITextField!
    @IBOutlet weak var Symbol2Label: UITextField!
    @IBOutlet weak var Symbol3Label: UITextField!
    
    @IBOutlet weak var ExchangeRate1Label: UITextField!
    @IBOutlet weak var ExchangeRate2Label: UITextField!
    @IBOutlet weak var ExchangeRate3Label: UITextField!

    @IBOutlet weak var Percentage1Label: UITextField!
    @IBOutlet weak var Percentage2Label: UITextField!
    @IBOutlet weak var Percentage3Label: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Symbol1Label.text = GlobalVariable.currencyUnit1
        Symbol2Label.text = GlobalVariable.currencyUnit2
        Symbol3Label.text = GlobalVariable.currencyUnit3
        
        ExchangeRate1Label.text = String(GlobalVariable.exchangeRate1)
        ExchangeRate2Label.text = String(GlobalVariable.exchangeRate2)
        ExchangeRate3Label.text = String(GlobalVariable.exchangeRate3)
        
        Percentage1Label.text = "\(Int(GlobalVariable.percentage1 * 100))"
        Percentage2Label.text = "\(Int(GlobalVariable.percentage2 * 100))"
        Percentage3Label.text = "\(Int(GlobalVariable.percentage3 * 100))"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalVariable.currencyUnit1 = Symbol1Label.text!
        GlobalVariable.currencyUnit2 = Symbol2Label.text!
        GlobalVariable.currencyUnit3 = Symbol3Label.text!
        
        GlobalVariable.exchangeRate1 = Double(ExchangeRate1Label.text!)!
        GlobalVariable.exchangeRate2 = Double(ExchangeRate2Label.text!)!
        GlobalVariable.exchangeRate3 = Double(ExchangeRate3Label.text!)!
        
        GlobalVariable.percentage1 = Double(Percentage1Label.text!)!
        GlobalVariable.percentage2 = Double(Percentage2Label.text!)!
        GlobalVariable.percentage3 = Double(Percentage3Label.text!)!
    }

    @IBAction func rateChanging(_ sender: AnyObject) {
        
        
    }
    
    @IBAction func percentageChanging(_ sender: AnyObject) {
        
    }
}
