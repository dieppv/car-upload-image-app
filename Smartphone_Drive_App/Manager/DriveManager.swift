//
//  DriveManager.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/21/20.
//  Copyright © 2020 Hai Nguyen Personal. All rights reserved.
//

import Foundation
import UIKit

enum DriveType {
    case none
    case smartphone
}

class DriveManager {
    static let shared = DriveManager()
    
    var lstResultWithoutPhone: [Double] = []
    var resultWithPhone: Double = 0.0
    
    var currentTest = 0 //0..4
    
    func getNextDrive(result: Double? = nil) -> UIViewController? {
        var vc: UIViewController?
        if currentTest >= 4 {
            self.resultWithPhone = result ?? 0
            vc = nil
            if self.average() != nil && resultWithPhone != 0 {
                vc = SuccessVC()
            } else {
                vc = FaildVC()
            }
            print("///////")
            print(lstResultWithoutPhone)
            print(resultWithPhone)
            print("///////")
        } else if currentTest == 3 {
            self.lstResultWithoutPhone.append(result ?? 0)
            vc = DriveVC.instance(type: .smartphone)
        } else {
            if let rs = result {
                self.lstResultWithoutPhone.append(rs)
            }
            vc = DriveVC.instance(type: .none)
        }
        currentTest += 1
        return vc
    }
    
    func average() -> Double? {
//        var count = 0
//        var sum: Double = 0
//        for i in self.lstResultWithoutPhone {
//            if i != 0.0 {
//                count += 1
//                sum += i
//            }
//        }
//        return count == 0 ? nil : sum / Double(count)
        print(lstResultWithoutPhone)
        print(lstResultWithoutPhone.filter{$0 != 0})
        return lstResultWithoutPhone.filter{$0 != 0}.min()
//        return self.lstResultWithoutPhone.min()
    }
    
    func reset() {
        currentTest = 0
        lstResultWithoutPhone = []
        resultWithPhone = 0.0
    }
}
