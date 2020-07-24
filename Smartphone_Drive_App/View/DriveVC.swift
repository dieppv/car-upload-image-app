//
//  FirstDriveVC.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/15/20.
//  Copyright © 2020 Hai Nguyen Personal. All rights reserved.
//

import UIKit

class DriveVC: UIViewController {
    
    //MARK: - OUTLET
    
    @IBOutlet weak var btnBrake: UIButton!
    @IBOutlet weak var btnAccel: UIButton!
    @IBOutlet weak var imvRoad: UIImageView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var vwAction: UIView!
    @IBOutlet weak var imvSmartPhone: UIImageView!
    @IBOutlet weak var imvPhoneTopConstraint: NSLayoutConstraint!
    
    //MARK: - PROPERTIES
    var h: CGFloat = 0
    var w: CGFloat = 0
    
    var direction: Direction = .left
    var carAsset: UIImage? = AssetManager.getImage(.carLeft1)
    
    var driveType: DriveType = .none
    var smartphoneRunning = false
    
    var time: TimeInterval = 0.0
    var beginTime: TimeInterval = 0.0
    var endTime: TimeInterval = 0.0
    var duration: TimeInterval = 0.0
    
    //count time hold accel button
    var accelTimer: Timer!
    var treeTimer: Timer!
    var count = 0
    
    //car
    
    var carAnimator: UIViewPropertyAnimator?
    var size: CGFloat = 30
    var bigSize: CGFloat = 0
    var running = true
    var timer: Timer?
    
    
    static func instance(type: DriveType = .none) -> DriveVC {
        let vc = DriveVC()
        vc.driveType = type
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model == "iPad" {
            imvPhoneTopConstraint.constant = -250
        } else {
            imvPhoneTopConstraint.constant = -155
        }
        setupUI()
        getAsset()
    }
    
    private func getAsset() {
        
        switch self.driveType {
        case .none:
            imvSmartPhone.isHidden = true
            let data = AssetManager.getRandomCar()
            direction = data.direction
            carAsset = data.asset
            btnBrake.isUserInteractionEnabled = true
        default:
            imvSmartPhone.isHidden = false
            imvSmartPhone.image = AssetManager.getRandomSmartphone()
            let data = AssetManager.getBlurCar()
            direction = data.direction
            carAsset = data.asset
            btnBrake.isUserInteractionEnabled = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        h = imvRoad.frame.height
        w = imvRoad.frame.width
        
        bigSize = h / 2
    }
    
    private func setupUI() {
        
        imvRoad.contentMode = .scaleToFill
        
        btnAccel.setImage(AssetManager.getImage(.accel), for: .normal)
        btnAccel.setImage(AssetManager.getImage(.accelHolder), for: .highlighted)
        
        btnBrake.setImage(AssetManager.getImage(.brake), for: .normal)
        btnBrake.setImage(AssetManager.getImage(.brakeHolder), for: .highlighted)
        
        btnBrake.addTarget(self, action: #selector(self.brakeBegin(sender:)), for: .touchDown)
        btnBrake.addTarget(self, action: #selector(self.brakeEnd(sender:)), for: .touchUpInside)
        
        btnAccel.addTarget(self, action: #selector(self.accelBegin(sender:)), for: .touchDown)
        btnAccel.addTarget(self, action: #selector(self.accelEnd(sender:)), for: .touchUpInside)
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(moveTree), userInfo: nil, repeats: true)
    }
    

    //MARK: - brake
    @objc func brakeBegin(sender: UIButton) {
        //        beginTime = Date().timeIntervalSinceReferenceDate
        
        //if vehicle runing => log brake time
        //else => pause tree
        
        //stop car

        if driveType == .smartphone {
            pause()
            SoundManager.shared.playTone(asset: .brake)
        } else {
            SoundManager.shared.playTone(asset: .brake2)
        }
        
        if carAnimator != nil && carAnimator?.isRunning ?? false {
            carAnimator?.pauseAnimation()
            
            //log time end
            endTime = Date().timeIntervalSince1970
            duration = endTime - beginTime
            debugPrint("time end: \(endTime)")
            
            debugPrint("duration: \(endTime - beginTime)")
            debugPrint("duration round: \(String(format: "%.3f", endTime - beginTime))")
            
            vwAction.isUserInteractionEnabled = false
            self.gotoNextScene()
        }
        
        
    }
    
    
    @objc func brakeEnd(sender: UIButton) {
        print("end")

    }
    
    //MARK: - accel
    @objc func accelBegin(sender: UIButton) {
        if driveType == .smartphone && smartphoneRunning {
            return
        }
        smartphoneRunning = true
        runAccelTimer()
        //run tree
        resume()
    }
    
    @objc func accelEnd(sender: UIButton) {
        if driveType == .smartphone {
            return
        }
        if accelTimer != nil {
            accelTimer.invalidate()
            accelTimer = nil
        }
        
        //pause tree
        //if timeout => tree still runing
        pause()
        
    }
    
    @objc func countTime() {
        count += 1
        if count >= 5 {
            
            addCar()
            
            accelTimer.invalidate()
            accelTimer = nil
            print("vihicle run")
            //run vehicle
            //log begin time
            
        }
        
        leftTree()
        
    }
    
    @objc func runAccelTimer() {
        accelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)

        treeTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(leftTree), userInfo: nil, repeats: true)

    }
    
    @objc func moveTree() {
        let tree = AssetManager.getImage(.tree)
        let imvTree = UIImageView(image: tree)
        imvTree.contentMode = .scaleToFill
        vwContent.addSubview(imvTree)
        imvTree.frame = CGRect(x: w / 2, y: h / 3, width: size, height: size * 4 / 3)
        
        UIView.animate(withDuration: 3, animations: {
            imvTree.frame = CGRect(x: -self.bigSize , y: self.h * 2 / 3, width: self.bigSize, height: self.bigSize * 4 / 3)
            self.view.layoutIfNeeded()
        }) { (completed) in
            imvTree.removeFromSuperview()
        }
    }
    
    private func addCollision() {
        if self.driveType == .none { return }
        let img = AssetManager.getCollision(direction: self.direction)
        let imv = UIImageView(image: img)
        
        self.vwContent.addSubview(imv)
        imv.frame = vwContent.frame
    }
    
    var animations : (() -> ())!
    var animators : [UIViewPropertyAnimator] = []
    
    func pause() {
        for i in animators {
            i.pauseAnimation()
        }
        if treeTimer != nil {
            treeTimer.invalidate()
            treeTimer = nil
        }
        SoundManager.shared.pause()
    }
    
    func resume() {
        for i in animators {
            
            if !i.isRunning {
                i.startAnimation()
            }
        }
        SoundManager.shared.playTone(asset: .drive)
    }
    
    private func gotoNextScene() {
        carAnimator?.stopAnimation(true)
        for i in animators {
            i.stopAnimation(true)
        }

        if let vc = DriveManager.shared.getNextDrive(result: duration) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            let vc = FaildVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: - Add Image
extension DriveVC {
    @objc func leftTree() {
        let tree = AssetManager.getImage(.tree)
        let imvTree = UIImageView(image: tree)
        imvTree.contentMode = .scaleToFill
        vwContent.addSubview(imvTree)
        imvTree.frame = CGRect(x: w / 2, y: h / 3, width: size, height: size * 5 / 4)
        animations = {
            imvTree.frame = CGRect(x: -1.5 * self.bigSize , y: self.h * 2 / 3, width: self.bigSize, height: self.bigSize * 5 / 4)
            self.view.layoutIfNeeded()
        }
        
        let animator = UIViewPropertyAnimator(duration: 3.5, curve: .easeIn)
        
        let completion: (UIViewAnimatingPosition) -> () = { position in

            imvTree.removeFromSuperview()
            if self.animators.count > 0 {
                self.animators.removeFirst()
                //                removedAnimator.stopAnimation(false)
            }
            
        }
        
        animator.addAnimations(animations)
        animator.addCompletion(completion)
        animator.startAnimation()
        
        animators.append(animator)
        
        rightTree()
    }
    
    @objc func rightTree() {

        let tree = AssetManager.getImage(.tree)
        let imvTree = UIImageView(image: tree)
        imvTree.contentMode = .scaleToFill
        vwContent.addSubview(imvTree)
        imvTree.frame = CGRect(x: w / 2 + w / 15, y: h / 3, width: size, height: size * 5 / 4)
        animations = {
            imvTree.frame = CGRect(x: self.w + self.bigSize , y: self.h * 2 / 3, width: self.bigSize, height: self.bigSize * 5 / 4)
            self.view.layoutIfNeeded()
        }
        
        let animator = UIViewPropertyAnimator(duration: 3.5, curve: .easeIn)
        
        let completion: (UIViewAnimatingPosition) -> () = { position in
            
            imvTree.removeFromSuperview()
            if self.animators.count > 0 {
                self.animators.removeFirst()
                //                removedAnimator.stopAnimation(false)
            }
            
        }
        
        animator.addAnimations(animations)
        animator.addCompletion(completion)
        animator.startAnimation()
        
        animators.append(animator)
    }
    private func addCar() {
        //left
        let carSize: CGFloat = h / 5
        let carBigSize: CGFloat = h / 2.2
        let car = self.carAsset
        let imvCar = UIImageView(image: car)
        imvCar.contentMode = .scaleToFill
        vwContent.addSubview(imvCar)
        
        var beginFrame: CGRect!
        var endFrame: CGRect!
        switch self.direction {
        case .left:
            beginFrame = CGRect(x: w / 3 , y: h * 1.5 / 3, width: carSize, height: carSize * 4 / 5)
            endFrame = CGRect(x: self.w * 1 / 2 , y: self.h / 2, width: carBigSize, height: carBigSize * 4 / 5)
        case .right:
            beginFrame = CGRect(x: w * 2 / 3 , y: h * 1.5 / 3, width: carSize, height: carSize * 4 / 5)
            endFrame = CGRect(x: self.w / 3.5 , y: self.h / 2, width: carBigSize, height: carBigSize * 4 / 5)
        }
        imvCar.frame = beginFrame
        
        let animation = {
            imvCar.frame = endFrame
            self.view.layoutIfNeeded()
        }
        let completion: (UIViewAnimatingPosition) -> () = { position in
            
            self.carAnimator = nil
            //pause tree
            self.pause()
            self.vwAction.isUserInteractionEnabled = false
            
            self.addCollision()
            switch self.driveType {
            case .smartphone:
                SoundManager.shared.playTone(asset: .crash)
            default:
                SoundManager.shared.playTone(asset: .hit)
            }
            
            self.gotoNextScene()
        }
        if carAnimator !=  nil {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                self.carAnimator?.pauseAnimation()
                self.carAnimator?.stopAnimation(true)
                self.carAnimator?.finishAnimation(at: .current)
            }
        }
        carAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeIn)
        
        carAnimator?.addAnimations(animation)
        carAnimator!.addCompletion(completion)
        
        btnBrake.isUserInteractionEnabled = true
        
        self.beginTime = Date().timeIntervalSince1970
        print("begin time car appearance: \(beginTime)")
        carAnimator!.startAnimation()
        
        
    }
}
