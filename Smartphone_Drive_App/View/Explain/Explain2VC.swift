//
//  Explain2VC.swift
//  Smartphone_Drive_App
//
//  Created by Creato Mac mini 5 on 7/21/20.
//

import UIKit

class Explain2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnDoneTapped(_ sender: Any) {

        DriveManager.shared.reset()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = SplashVC()
    }
    

}
