//
//  ViewController.swift
//  LocationNotification
//
//  Created by Mac de Laurent on 02/01/2020.
//  Copyright © 2020 Laurent L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TokenLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
    }
    
    func loadRequest(for deviceTokenString : String)
    {
        TokenLabel.text = deviceTokenString
    }


}

