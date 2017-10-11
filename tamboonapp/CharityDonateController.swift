//
//  CharityDonateController.swift
//  tamboonapp
//
//  Created by admin on 10/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import os.log
//import Ala
import Alamofire

class CharityDonateController: UIViewController {
    
    @IBOutlet weak var donateAmountTxt: UITextField!
    @IBOutlet weak var donatePanTxt: UITextField!
    @IBOutlet weak var donateCardCvv2Txt: UITextField!
    @IBOutlet weak var donateCardNameTxt: UITextField!
    @IBOutlet weak var donateCardExpiryMonthTxt: UITextField!
    @IBOutlet weak var donateCardExpiryYearTxt: UITextField!
    
    @IBOutlet weak var donateConfirmBtn: UIBarButtonItem!
    
    @IBOutlet weak var donateLoading: UIActivityIndicatorView!
    var donate: DonateReq?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.donateLoading.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func donateConfirm(_ sender: UIBarButtonItem) {
        
        self.donateLoading.isHidden = false
        self.donateLoading.startAnimating()
        
        let name = donateCardNameTxt.text == "" ? "test" : donateCardNameTxt.text
        let pan = donatePanTxt.text == "" ? "4111111111111111" : donateCardNameTxt.text
        let expiryMonth = donateCardExpiryMonthTxt.text == "" ? "12" : donateCardExpiryMonthTxt.text
        let expiryYear = donateCardExpiryYearTxt.text == "" ? "2017" : donateCardExpiryYearTxt.text
        let cvv2 = donateCardCvv2Txt.text == "" ? "999" : donateCardCvv2Txt.text
        let amount = donateAmountTxt.text == "" ? "0.0" : donateAmountTxt.text
        
        let parameters: Parameters = [
            "name": name as Any,
            "pan": pan as Any,
            "expiryMonth" : expiryMonth as Any,
            "expiryYear" : expiryYear as Any as Any,
            "cvv2" : cvv2 as Any,
            "amount" : amount as Any,
            "charityName" : "-"
        ]
        
        Alamofire.request("http://localhost:8080/donate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        let oResult = self.storyboard?.instantiateViewController(withIdentifier: "DonateResultView") as! CharityDonateResultController
                        
                        oResult.donateResult = true
                        self.navigationController?.pushViewController(oResult, animated: true)
                    default:
                        let oResult = self.storyboard?.instantiateViewController(withIdentifier: "DonateResultView") as! CharityDonateResultController
                        
                        oResult.donateResult = false
                        self.navigationController?.pushViewController(oResult, animated: true)
                    }
                }
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
 

}
