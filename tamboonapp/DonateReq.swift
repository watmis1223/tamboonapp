//
//  DonateReq.swift
//  tamboonapp
//
//  Created by admin on 10/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class DonateReq: Codable {
    
    //MARK: Properties
    
    var name: String
    var pan: String
    var expiryMonth: Int
    var expiryYear: Int
    var amount: Decimal
    var cvv2: String
    
    init?(name: String, pan: String, expiryMonth: Int, expiryYear: Int, cvv2: String, amount: Decimal) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || amount < 1  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.pan = pan
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
        self.cvv2 = cvv2
        self.amount = amount
        
    }
}
