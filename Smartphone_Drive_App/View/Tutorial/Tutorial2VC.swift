//
//  Tutorial2VC.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/21/20.
//

import UIKit

class Tutorial2VC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        if let vc = DriveManager.shared.getNextDrive() {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
