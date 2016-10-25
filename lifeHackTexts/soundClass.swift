//
//  soundClass.swift
//  lifeHackTexts
//
//  Created by Felipe Samuel Rodriguez on 10/25/16.
//  Copyright © 2016 Technigraphic. All rights reserved.
//

import AVFoundation

class soundClass {
    static let sharedHelper = soundClass()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        
        do {
            audioPlayer = try? AVAudioPlayer(contentsOf:URL(fileURLWithPath:Bundle.main.path(forResource: "mineTone", ofType: "wav")! ))
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            
        }
    }
}
