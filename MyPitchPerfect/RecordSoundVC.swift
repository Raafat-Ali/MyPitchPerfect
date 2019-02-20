//
//  ViewController.swift
//  MyPitchPerfect
//
//  Created by Raafat Ali on 07/11/2018.
//  Copyright © 2018 Raafat Ali. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundVC: UIViewController, AVAudioRecorderDelegate {
 
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var stopRecordBtn: UIButton!
    @IBOutlet weak var startRecordBtn: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    stopRecordBtn.isHidden = true
        
    }
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
      }
    
    //Mark : - UI State
    func setUIState(isRecording:Bool, recordingText:String)
    {
        if recordingText == "Recording..." {
            recordingLabel.text = "Tap to Stop Recording"
        }
        if recordingText == "N/A"{
           recordingLabel.text = "Tap to Start Recording"
        }
        stopRecordBtn.isEnabled = isRecording
        startRecordBtn.isEnabled = isRecording
        
    }
    
    //MARK : - UI Configuration Funcion
    
    func uiConfig(_ isRecording: Bool ){
        if isRecording == true {
            
            stopRecordBtn.isHidden = false
            
            startRecordBtn.isHidden = true
       
            recordingLabel.font = UIFont.italicSystemFont(ofSize: 18)
            recordingLabel.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
            statusLabel.text = "Recording..."
            statusLabel.textColor = UIColor.white
          
        }
        
        if isRecording == false {
       
            stopRecordBtn.isHidden = true
            
      
            startRecordBtn.isHidden = false
    
            recordingLabel.font = UIFont.systemFont(ofSize: 20)
            recordingLabel.textColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            statusLabel.text = "N/A"
            statusLabel.textColor = UIColor.darkGray
            
        }
        
        setUIState(isRecording: isRecording, recordingText: statusLabel.text! )
    }

    //Mark: - Record button Pressed

    @IBAction func recordBtnPress(_ sender: Any) {
   
        //call UI configuration func
        uiConfig(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try!session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default  ,options:AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "playscene", sender: audioRecorder.url)
        }else{
            let alert = UIAlertController(title: "Recording Failed", message: "recording failed, try again please", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        }
    
    
    //segue preparing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playscene"{
            let playSndVC = segue.destination as! PlaySoundsVC
            let recordedAudiURL = sender as! URL
            playSndVC.recordedAudioURL = recordedAudiURL
        }
    }
    
    
    //Mark: - Stop Recording Pressed
    @IBAction func stopRecordPress(_ sender: Any) {
        
        audioRecorder.stop() // stop recording
        
        uiConfig( false) // call UI configuration func
        
      
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    


}

