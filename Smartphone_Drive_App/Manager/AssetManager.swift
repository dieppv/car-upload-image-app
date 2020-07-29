//
//  AssetManager.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/15/20.
//

import UIKit

enum Asset: String {
    case brake = "brake_img"
    case brakeHolder = "brake_img2"
    case accel = "accel_img"
    case accelHolder = "accel_img2"
    
    case tree = "tree"
    
    case carLeft1 = "car_left1"
    case carLeft2 = "car_left2"
    case carLeft3 = "car_left3"
    case carLeft4 = "car_left4"
    
    case carLeft6 = "car_left6"
    
    case carRight1 = "car_right1"
    case carRight2 = "car_right2"
    case carRight3 = "car_right3"
    case carRight4 = "car_right4"
    
    case carRight6 = "car_right6"
    
    case smartphone1 = "smart_phone1"
    case smartphone2 = "smart_phone2"
    case smartphone3 = "smart_phone3"
    case smartphone4 = "smart_phone4"
    case smartphone5 = "smart_phone5"
    case smartphone6 = "smart_phone6"
    case smartphone7 = "smart_phone7"

    case collisionLeft = "collision_l"
    case collisionRight = "collision_r"
}

enum Direction {
    case left
    case right
}

class AssetManager {
    
    static let shared = AssetManager()
    
    static func getImage(_ asset: Asset) -> UIImage? {
        return UIImage(named: asset.rawValue)
    }
    
    static func getRandomCar() -> (asset: UIImage?, direction: Direction) {
        let randomInt = Int.random(in: 1..<5)
        let randomBool = Bool.random()
        let direction: Direction = randomBool ? .left : .right

        switch direction {
        case .left:
            return (getImage(Asset(rawValue: "car_left\(randomInt)") ?? .carLeft1), .left)
        case .right:
            return (getImage(Asset(rawValue: "car_right\(randomInt)") ?? .carRight1), .right)
        }
    }
    
    static func getBlurCar() -> (asset: UIImage?, direction: Direction) {
        let randomBool = Bool.random()
        let direction: Direction = randomBool ? .left : .right

        switch direction {
        case .left:
            return (getImage(.carLeft6), .left)
        case .right:
            return (getImage(.carRight6), .right)
        }
    }
    
    static func getRandomSmartphone() -> UIImage? {
        let randomInt = Int.random(in: 5..<8)
        return getImage(Asset(rawValue: "smart_phone\(randomInt)") ?? .smartphone1)
    }
    
    static func getCollision(direction: Direction) -> UIImage? {
        switch direction {
        case .left:
            return getImage(.collisionLeft)
        case .right:
            return getImage(.collisionRight)
        }
    }
}


class DeviceManager {
    enum Egde {
        case height
        case width
    }
    
    static func getSize(_ egde: Egde) -> CGFloat {
        switch egde {
        case .height:
            return UIScreen.main.bounds.size.height
        case .width:
            return UIScreen.main.bounds.size.width
        }
    }
}
