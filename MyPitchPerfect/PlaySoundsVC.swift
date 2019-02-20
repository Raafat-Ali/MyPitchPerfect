//
//  PlaySoundsVC.swift
//  MyPitchPerfect
//
//  Created by Raafat Ali on 07/11/2018.
//  Copyright © 2018 Raafat Ali. All rights reserved.
//

import UIKit
 import AVFoundation

class PlaySoundsVC: UIViewController {
    
    @IBOutlet weak var snailBtn: UIButton!
    @IBOutlet weak var rabbitBtn: UIButton!
    @IBOutlet weak var chipmunkBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var vaderBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    
    @IBOutlet weak var playStatusLabel: UILabel!
    
    var recordedAudioURL : URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //Buttons Enum for the all the buttons on the PlaySounds View Controller
    enum ButtonS : Int{case slow = 0 , fast, chipmunk, vader, echo, reverb, stopPlay;
    // return the correspond raw value as string
        var description:String{
            return String(describing: self)
        }
        
    }
    
    // Mark : - play audio correspond to the pressed button tag Or stop playing button tag then calling the UI configuration to display the playing status & the current sound effect
    
    @IBAction func soundPlay(_ sender: UIButton){
        switch (ButtonS(rawValue:sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
            configureUI(.playing, .slow)
        case .fast:
            playSound(rate: 2.0)
             configureUI(.playing, .fast)
        case .chipmunk:
            playSound(rate: 1600)
             configureUI(.playing, .chipmunk)
        case .vader:
            playSound(rate: -1000)
             configureUI(.playing, .vader)
        case .echo:
            playSound(echo: true)
             configureUI(.playing, .echo)
        case .reverb:
            playSound(reverb:true)
             configureUI(.playing, .reverb)
        case .stopPlay:
             stopAudio()        }
 
       
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
      
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying, .stopPlay)
        
        navigationItem.hidesBackButton = true
    }
 

}
