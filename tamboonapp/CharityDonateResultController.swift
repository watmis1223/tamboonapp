//
//  CharityDonateResultController.swift
//  tamboonapp
//
//  Created by admin on 10/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class CharityDonateResultController: UIViewController {

    @IBOutlet weak var donateResultLabel: UILabel!
    var donateResult: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (donateResult) {
            donateResultLabel.text = "Donate Success"
        }else {
            donateResultLabel.text = "Donate Failed"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
