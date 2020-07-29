//
//  SplashVC.swift
//  Smartphone_Drive_App
//
//  Created by DiepPV Mac mini 5 on 7/21/20.
//

import UIKit

class PrimaryButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(UIColor.black, for: .normal)
    }
}

class SplashVC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnNextTapped(_ sender: Any) {
        let vc = TutorialVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
