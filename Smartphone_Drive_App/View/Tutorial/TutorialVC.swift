//
//  TutorialVC.swift
//  Smartphone_Drive_App
//
//  Created by DiepPV Mac mini 5 on 7/21/20.
//

import UIKit

class TutorialVC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnNextTapped(_ sender: Any) {
        let vc = Tutorial2VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
