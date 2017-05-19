//
//  Audio.swift
//  InteractiveStory
//
//  Created by Iván Martínez on 19/05/17.
//  Copyright © 2017 Iván Martínez. All rights reserved.
//

import Foundation
import AudioToolbox

extension Story {
    var soundEffectName: String {
        switch self {
        case .droid, .home:
            return "HappyEnding"
        case .monster:
            return "Ominous"
        default:
            return "PageTurn"
        }
    }
    
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0
    
    func playSound(for story: Story) {
        let soundURL = story.soundEffectURL as CFURL // No exclamation point, no question mark because this is a seamless transition.
        AudioServicesCreateSystemSoundID(soundURL, &sound) // An ampersand in front of a variable name creates an inout parameter. (This is called a Pointer)
        AudioServicesPlaySystemSound(sound)
    }
}
