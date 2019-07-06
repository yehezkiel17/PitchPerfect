//
//  ViewController.swift
//  PitchPerfect
//
//  Created by AIMSIS on 15/4/18.
//  Copyright © 2018 AIMSIS. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	// MARK: Properties
	var audioRecorder: AVAudioRecorder!

	// MARK: Outlets
	@IBOutlet weak var recordingLabel: UILabel!
	@IBOutlet weak var recordButton: UIButton!
	@IBOutlet weak var stopRecordButton: UIButton!

	// MARK: Actions
	// IBAction for record button
	@IBAction func recordButtonAction(_ sender: UIButton) {
		configureUI(isRecording: true)

		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as String
		let recordingName = "recordedAudio.wav"
		let pathArray = [dirPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))

		let session = AVAudioSession.sharedInstance()
		try? session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)

		try? audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
	}

	// IBAction for stop button
	@IBAction func stopRecordButtonAction(_ sender: UIButton) {
		configureUI(isRecording: false)

		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try? audioSession.setActive(false)
	}

	// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI(isRecording: false)
	}

	// Notifies the view controller that a segue is about to be performed.
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecordingSegue" {
			let playAudioVC = segue.destination as? PlaySoundsViewController
			let recordedAudioURL = sender as? URL
            playAudioVC?.recordedAudioURL = recordedAudioURL
		}
	}

	// MARK: - Audio Recorder Delegate
	// Called by the system when a recording is stopped or has finished due to reaching its time limit.
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
		} else {
			print("Recording was not successful")
		}
	}

	// Configure the label and buttons
	func configureUI(isRecording: Bool) {
		if isRecording {
			recordingLabel.text = "Recording in Progress"
			recordButton.isEnabled = false
			stopRecordButton.isEnabled = true
		} else {
			recordingLabel.text = "Tap to Record"
			recordButton.isEnabled = true
			stopRecordButton.isEnabled = false
		}
	}
}
