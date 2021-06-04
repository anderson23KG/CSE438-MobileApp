//
//  ViewController.swift
//  Calculator_Version1
//
//  Created by Anderson Gonzalez on 6/17/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var finalPrice: UITextField!
    
    @IBOutlet weak var discount: UITextField!
    
    @IBOutlet weak var salesTax: UITextField!
    
    @IBOutlet weak var priceError: UILabel!
    
    @IBOutlet weak var discountError: UILabel!
    
    @IBOutlet weak var salesError: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var listTotal: UITextField!
    
    var listTotalDouble = Double(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        salesError.alpha = 1
        discountError.alpha = 1
        priceError.alpha = 1
        listTotal.text = ""
        finalPrice.text = ""
        listTotalDouble = Double(0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func priceChanged(_ sender: Any) {
        let priceInt: Double? = Double(price.text!)
        let discountInt: Double? = Double(discount.text!)
        let salesTaxInt: Double? = Double(salesTax.text!)
        if priceInt != nil && (priceInt! > 0 ) {
            priceError.alpha = 0
            if discountInt != nil && salesTaxInt != nil{
                if discountInt! >= 0 && salesTaxInt! >= 0 && salesTaxInt! <= 100 && discountInt! <= 100 {
                    let finalInt = Double(priceInt! + salesTaxInt!/100*priceInt!-discountInt!/100*priceInt!)
                    finalPrice.text = "\(String(format: "%.2f", finalInt))"
                    finalPrice.textColor = UIColor.black
                }
            }
            else {
                finalPrice.text = "Error"
                finalPrice.textColor = UIColor.red
            }
        }
        else{
            finalPrice.text = "Error"
            finalPrice.textColor = UIColor.red
            priceError.alpha = 1
        }
    }
    
    
    @IBAction func discountChange(_ sender: Any) {
        let priceInt: Double? = Double(price.text!)
        let discountInt: Double? = Double(discount.text!)
        let salesTaxInt: Double? = Double(salesTax.text!)
        if discountInt != nil && (discountInt! >= 0 ) && (discountInt! <= 100){
            discountError.alpha = 0
            if priceInt != nil && salesTaxInt != nil{
                if priceInt! > 0 && (salesTaxInt! >= 0 ) && (salesTaxInt! <= 100){
                    let finalInt = Double(priceInt! + salesTaxInt!/100*priceInt!-discountInt!/100*priceInt!)
                    finalPrice.text = "\(String(format: "%.2f", finalInt))"
                    finalPrice.textColor = UIColor.black
                }
            }
            else {
                finalPrice.text = "Error"
                finalPrice.textColor = UIColor.red
                finalPrice.textColor = UIColor.red
            }
            
        }
        else{
            finalPrice.text = "Error"
            finalPrice.textColor = UIColor.red
            discountError.alpha = 1
        }
        
    }
    
    @IBAction func taxChanged(_ sender: Any) {
        let priceInt: Double? = Double(price.text!)
        let discountInt: Double? = Double(discount.text!)
        let salesTaxInt: Double? = Double(salesTax.text!)
        if salesTaxInt != nil && (salesTaxInt! >= 0 ) && (salesTaxInt! <= 100){
            salesError.alpha = 0
            if priceInt != nil && discountInt != nil{
                if priceInt! > 0 && (discountInt! >= 0) && (discountInt! <= 100){
                    let finalInt = Double(priceInt! + salesTaxInt!/100*priceInt!-discountInt!/100*priceInt!)
                    finalPrice.text = "\(String(format: "%.2f", finalInt))"
                    finalPrice.textColor = UIColor.black
                }
            }
            else {
                finalPrice.text = "Error"
                finalPrice.textColor = UIColor.red
            }
            
        }
        else{
            finalPrice.text = "Error"
            finalPrice.textColor = UIColor.red
            salesError.alpha = 1
        }
    }
    
    
    @IBAction func addToList(_ sender: UIButton) {
        let finalPriceDouble: Double? = Double(finalPrice.text!)
        if finalPriceDouble != nil  && finalPriceDouble! > 0
        {
            listTotalDouble += finalPriceDouble!
            listTotal.text = "\(String(format: "%.2f", listTotalDouble))"
        }
    }
    
    
    @IBAction func clearList(_ sender: UIButton) {
        listTotalDouble = 0.00
        listTotal.text = "\(String(format: "%.2f", listTotalDouble))"
    }
    
}

