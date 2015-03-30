//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jojo Commi on 3/11/15.
//  Copyright (c) 2015 Jojocommi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
        recordingInProgress.hidden = false
        //Hide the stop button
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false
        //Changes the UI label to a different text
        let NowRecordingText = "Now recording"
        recordingInProgress.text = "Now recording"
        //recordingInProgress.hidden = true
        //self.recordingInProgress.text = "Now Recording"
        
        
        //TODO: Record the user's voice
        println("in recordAudio")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        //Setup audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Initialize and prepare the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag{
            recordedAudio = RecordedAudio(filePathURL: recorder.url, title:recorder.url.lastPathComponent!)
       

        //TODO 2. Move to the second scene of the app aka perform a segue
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        
        }else{
            println("Recording was not successful")
          recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as
            PlaySoundsViewController
        let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        //Changes the UI label back to the original text
        let TapToRecordText = "Tap to Record..."
            recordingInProgress.text = "Tap to Record"
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioRecorder.stop()
        //TODO to stop recording the user's voice
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }

}

