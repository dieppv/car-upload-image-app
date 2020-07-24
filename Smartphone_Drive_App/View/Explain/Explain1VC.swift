//
//  Explain1VC.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/21/20.
//

import UIKit

class Explain1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        let vc =  Explain2VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

}
