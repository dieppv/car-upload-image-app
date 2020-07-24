//
//  FaildVC.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/21/20.
//  Copyright © 2020 Hai Nguyen Personal. All rights reserved.
//

import UIKit

class FaildVC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        DriveManager.shared.reset()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = SplashVC()
    }

}
