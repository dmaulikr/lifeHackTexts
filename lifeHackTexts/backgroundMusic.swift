//
//  soundClass.swift
//  lifeHackTexts
//
//  Created by Felipe Samuel Rodriguez on 10/25/16.
//  Copyright © 2016 Technigraphic. All rights reserved.
//

import SpriteKit

class BackgroundSound: SKScene{
    static let sharedHelper = BackgroundSound()
    var backgroundMusic = SKAudioNode()
    
    override func didMove(to view: SKView) {
        backgroundMusic = SKAudioNode(fileNamed:"mineTone.wav")
        addChild(backgroundMusic)
    }
    
    
}
