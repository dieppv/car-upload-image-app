//
//  SuccessVC.swift
//  Smartphone_Drive_App
//
//  Created by DiepPV Mac mini 5 on 7/21/20.
//

import UIKit

class SuccessVC: UIViewController {

    @IBOutlet weak var lblNonSmartphone: UILabel!
    @IBOutlet weak var lblSmartphoneDriving: UILabel!
    @IBOutlet weak var lblDifference: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rsWithPhone = DriveManager.shared.resultWithPhone
        let rsWithoutPhone = DriveManager.shared.average() ?? 0.0
        lblSmartphoneDriving.text = String(format: "%.2f 秒", rsWithPhone)
        lblNonSmartphone.text = String(format: "%.2f 秒", rsWithoutPhone)
        
        lblDifference.text = String(format: "%.2f 秒", rsWithPhone > rsWithoutPhone ? rsWithPhone - rsWithoutPhone : rsWithoutPhone - rsWithPhone)
        
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        let vc = Explain1VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
