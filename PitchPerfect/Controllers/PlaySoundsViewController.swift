//
//  PlayAudioController.swift
//  PitchPerfect
//
//  Created by AIMSIS on 15/4/18.
//  Copyright © 2018 AIMSIS. All rights reserved.
//

import UIKit
import AVFoundation

public class PlaySoundsViewController: UIViewController {
	// MARK: Properties
	var recordedAudioURL:URL!
	var audioFile:AVAudioFile!
	var audioEngine:AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!

	enum ButtonType: Int {
		case slow, fast, chipmunk, vader, echo, reverb
	}

	// MARK: Outlets
	@IBOutlet weak var snailButton: UIButton!
	@IBOutlet weak var chipmunkButton: UIButton!
	@IBOutlet weak var rabbitButton: UIButton!
	@IBOutlet weak var vaderButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!

	// MARK: Actions
	// IBAction for play sound
	@IBAction func playSoundForButton(_ sender: UIButton) {
		switch(ButtonType(rawValue: sender.tag)!) {
		case .slow:
			playSound(rate: 0.5)
		case .fast:
			playSound(rate: 1.5)
		case .chipmunk:
			playSound(pitch: 1000)
		case .vader:
			playSound(pitch: -1000)
		case .echo:
			playSound(echo: true)
		case .reverb:
			playSound(reverb: true)
		}

		configureUI(.playing)
	}

	// IBAction for stop sound
	@IBAction func stopButtonPressed(_ sender: AnyObject) {
		stopAudio()
	}

	// Called after the controller's view is loaded into memory.
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupAudio()

		snailButton.imageView?.contentMode = .scaleAspectFit
		chipmunkButton.imageView?.contentMode = .scaleAspectFit
		rabbitButton.imageView?.contentMode = .scaleAspectFit
		vaderButton.imageView?.contentMode = .scaleAspectFit
		echoButton.imageView?.contentMode = .scaleAspectFit
		reverbButton.imageView?.contentMode = .scaleAspectFit
		stopButton.imageView?.contentMode = .scaleAspectFit
	}

	// Notifies the view controller that its view is about to be added to a view hierarchy.
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUI(.notPlaying)
	}
}
