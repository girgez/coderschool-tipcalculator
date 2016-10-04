//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by GIRGEZ on 10/3/16.
//  Copyright © 2016 GIRGEZ. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var ContainerPercentageBtns: UIView!
    @IBOutlet weak var ContainerCurrencyBtns: UIView!
    @IBOutlet weak var Percentage1Btn: UIButton!
    @IBOutlet weak var Percentage2Btn: UIButton!
    @IBOutlet weak var Percentage3Btn: UIButton!
    @IBOutlet weak var Currency1Btn: UIButton!
    @IBOutlet weak var Currency2Btn: UIButton!
    @IBOutlet weak var Currency3Btn: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var BillTextField: UITextField!
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    
    var keyboardIsShowing = false
    var percentage = 0.0
    var currency = ""
    var currentRate = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ContainerPercentageBtns.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        ContainerPercentageBtns.layer.borderWidth = 1
        ContainerPercentageBtns.layer.cornerRadius = 2
        
        ContainerCurrencyBtns.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        ContainerCurrencyBtns.layer.borderWidth = 1
        ContainerCurrencyBtns.layer.cornerRadius = 2
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
        
        Percentage1Btn.titleLabel?.text = "\(Int(GlobalVariable.percentage1 * 100))%"
        Percentage2Btn.titleLabel?.text = "\(Int(GlobalVariable.percentage2 * 100))%"
        Percentage3Btn.titleLabel?.text = "\(Int(GlobalVariable.percentage3 * 100))%"
        
        Currency1Btn.titleLabel?.text = GlobalVariable.currencyUnit1
        Currency2Btn.titleLabel?.text = GlobalVariable.currencyUnit2
        Currency3Btn.titleLabel?.text = GlobalVariable.currencyUnit3
        
        BillTextField.text = GlobalVariable.bill
        BillTextField.becomeFirstResponder()
        
        Percentage1(self)
        Currency1(self)
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        ScrollView.contentInset.bottom += adjustmentHeight
        ScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShowing {
            adjustInsetForKeyboardShow(show: true, notification: notification)
            keyboardIsShowing = true
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if keyboardIsShowing {
            adjustInsetForKeyboardShow(show: false, notification: notification)
            keyboardIsShowing = false
        }
    }
    
    func tipCalculator() {
        let bill = Double(BillTextField.text!)!
        let tip = bill * percentage
        let total = bill + tip
        TipLabel.text = String.init(format: "%.2f \(currency)", tip)
        TotalLabel.text = String.init(format: "%.2f \(currency)", total)
    }

    @IBAction func Percentage1(_ sender: AnyObject) {
        Percentage1Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Percentage2Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Percentage3Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        percentage = GlobalVariable.percentage1
        tipCalculator()
    }
    @IBAction func Percentage2(_ sender: AnyObject) {
        Percentage2Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Percentage1Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Percentage3Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        percentage = GlobalVariable.percentage2
        tipCalculator()
    }
    @IBAction func Percentage3(_ sender: AnyObject) {
        Percentage3Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Percentage1Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Percentage2Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        percentage = GlobalVariable.percentage3
        tipCalculator()
    }
    @IBAction func Currency1(_ sender: AnyObject) {
        Currency1Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Currency2Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Currency3Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        exchangeCurrency(rate: GlobalVariable.exchangeRate1, currencySymbol: GlobalVariable.currencyUnit1)
    }
    @IBAction func Currency2(_ sender: AnyObject) {
        Currency2Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Currency1Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Currency3Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        exchangeCurrency(rate: GlobalVariable.exchangeRate2, currencySymbol: GlobalVariable.currencyUnit2)
    }
    @IBAction func Currency3(_ sender: AnyObject) {
        Currency3Btn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        Currency1Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Currency2Btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        exchangeCurrency(rate: GlobalVariable.exchangeRate3, currencySymbol: GlobalVariable.currencyUnit3)
    }
    
    func exchangeCurrency(rate: Double, currencySymbol: String) {
        var bill = Double(BillTextField.text!)!
        bill = bill * rate / currentRate
        BillTextField.text = String.init(format: "%.2f", bill)
        currentRate = rate
        currency = currencySymbol
        tipCalculator()
    }
    
    @IBAction func BillEditing(_ sender: AnyObject) {
        print("change")
        if BillTextField.text == nil {
            return
        }
        
        let bill = BillTextField.text
        
        if bill!.isEmpty {
            BillTextField.text = "0"
            return
        }
        
        let check1 = NSPredicate(format: "SELF MATCHES %@", "\\d+\\.\\d+|\\d+")
        let check2 = NSPredicate(format: "SELF MATCHES %@", "\\d+\\.")
        let check3 = NSPredicate(format: "SELF MATCHES %@", "0\\d+\\.\\d+|0\\d+|0\\d+\\.")
        
        if check3.evaluate(with: bill) {
            let index = bill!.index(bill!.startIndex, offsetBy: 1)
            BillTextField.text = bill!.substring(from: index)
        }else if check1.evaluate(with: bill) {
            tipCalculator()
        } else if !check2.evaluate(with: bill) {
            let index = bill!.index(bill!.endIndex, offsetBy: -1)
            BillTextField.text = bill!.substring(to: index)
        }
    }
}
