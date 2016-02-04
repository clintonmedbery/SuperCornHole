//
//  AudioManager.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 2/3/16.
//  Copyright © 2016 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    static let audioManager = AudioManager();
    var introSound : AVAudioPlayer?
    var claps : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    var boardSounds = [AVAudioPlayer]()
    
    
    
    private init(){
        if let introSound = self.setupAudioPlayerWithFile("RoboCornhole", type:"wav") {
            self.introSound = introSound
        }
        if let claps = self.setupAudioPlayerWithFile("Clap1", type:"mp3") {
            self.claps = claps
        }
        if let board1 = self.setupAudioPlayerWithFile("board1", type:"wav") {
            self.boardSounds.append(board1)
        }
        if let board2 = self.setupAudioPlayerWithFile("board2", type:"wav") {
            self.boardSounds.append(board2)
        }
        if let board3 = self.setupAudioPlayerWithFile("board3", type:"wav") {
            self.boardSounds.append(board3)
        }
        
        
        if let backgroundMusic = self.setupAudioPlayerWithFile("natureBackground", type:"mp3") {
            self.backgroundMusic = backgroundMusic
            backgroundMusic.numberOfLoops = -1
        }
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    func playBackground(){
        backgroundMusic?.play()
    }
    
    func pauseBackground(){
        backgroundMusic?.pause()
    }
    
    func playClaps() {
        print("PLAYING CLAPS!!!!!!!!!!!!!!!!!!")
        self.claps?.numberOfLoops = 0
        self.claps?.prepareToPlay()
        self.claps?.play()
//        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue()) {
//            print("This is run on the main queue, after the previous code in outer block")
//            self.claps?.stop()
//        }
        
    }
    
    func playRandomBoard(){
        let randomIndex = Int(arc4random_uniform(UInt32(self.boardSounds.count)))
        self.boardSounds[randomIndex].numberOfLoops = 1
        self.boardSounds[randomIndex].prepareToPlay()
        self.boardSounds[randomIndex].play()

    }
    
   
}