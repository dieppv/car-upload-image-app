//
//  SoundManager.swift
//  Smartphone_Drive_App
//
//  Created by Ominext Mac mini 5 on 7/24/20.
//

import Foundation
import AVFoundation

enum SoundAsset: String {
    case brake = "brake"
    case brake2 = "brake2"
    case crash = "crash"
    case drive = "drive"
    case hit = "hit"
    
    func getType() -> String {
        switch self {
        case .brake, .crash:
            return "wav"
        default:
            return "mp3"
        }
    }
}
class SoundManager {
    
    static let shared = SoundManager()
    
    var player: AVAudioPlayer!
    
    func playTone(asset: SoundAsset) {
        let path = Bundle.main.path(forResource: asset.rawValue, ofType : asset.getType())!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print ("\(asset.rawValue).\(asset.getType())")
            player.play()
        }
        catch {
            print (error)
        }
    }
    
    func pause() {
        if player != nil {
            if player.isPlaying {
                player.pause()
            }
        }
        
    }
}
