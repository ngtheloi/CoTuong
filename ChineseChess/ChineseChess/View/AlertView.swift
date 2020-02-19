//
//  AlertView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1802//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
	func dismissViewController()
	func replayGame()
}

class AlertView: UIView {
	// Outlet
	@IBOutlet weak var alertContentView: UIView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var messageLbl: UILabel!
	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var okBtn: UIButton!
	@IBOutlet weak var resumeBtn: UIButton!
	
	static let identifier = "AlertView"
	var alertStyle: AlertStyle!
	var delegate: AlertViewDelegate!
	var timer: Timer!
	var pauseTimeLeft = MyAppDelegate.setting.pauseTimeLeft
	
	override func awakeFromNib() {
		super.awakeFromNib()
		MyAppDelegate.navigationView.configTimerState(true)
	}
	
	func loadText(_ style: AlertStyle) {
		var title = "Errors"
		var message = "Somethings wrong. Please wait!"
		var btn1 = "NO"
		var btn2 = "YES"
		alertStyle = style
		if alertStyle == .Winner {
			title = "Congratulation!"
			message = (MyAppDelegate.brain.winner == .Red) ? "Player 1 is winner" : "Player 2 is winner"
			btn1 = "Exit game"
			btn2 = "Replay"
		} else if alertStyle == .ExitGame {
			title = "Exit to Main Menu!"
			message = "Are you sure you want to return the main menu?"
			btn1 = "NO"
			btn2 = "YES"
		} else if alertStyle == .PauseGame {
			title = "Pause game!"
			message = "Are you sure you want to pause your turn?"
			btn1 = "NO"
			btn2 = "YES"
		} else if alertStyle == .Paused {
			title = "Paused"
			message = self.getCountDownTime()
		}
		titleLbl.text = title
		messageLbl.text = message
		cancelBtn.setTitle(btn1, for: .normal)
		okBtn.setTitle(btn2, for: .normal)
		self.loadUI()
		self.loadButtonsState()
	}
	
	func loadUI() {
		let viewCorner = alertContentView.bounds.size.height / 10
		alertContentView.layer.cornerRadius = viewCorner
		
		alertContentView.layer.borderWidth = 1
		alertContentView.layer.borderColor = UIColor.white.cgColor
		
		let buttonCorner = cancelBtn.bounds.size.height / 2
		cancelBtn.layer.cornerRadius = buttonCorner
		okBtn.layer.cornerRadius = buttonCorner
		resumeBtn.layer.cornerRadius = buttonCorner
		
		cancelBtn.layer.borderWidth = 1
		okBtn.layer.borderWidth = 1
		resumeBtn.layer.borderWidth = 1
		
		cancelBtn.layer.borderColor = UIColor.white.cgColor
		okBtn.layer.borderColor = UIColor.white.cgColor
		resumeBtn.layer.borderColor = UIColor.white.cgColor
	}
	
	func loadButtonsState() {
		cancelBtn.isHidden = alertStyle == .Paused
		okBtn.isHidden = alertStyle == .Paused
		resumeBtn.isHidden = alertStyle != .Paused
	}
	
	func startTimers() {
		self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
	}
	
	func stopTimers() {
		if self.timer != nil {
			self.timer.invalidate()
			self.timer = nil
		}
	}
	
	@objc func updateCounter() {
		//example functionality
		if pauseTimeLeft > 0 {
			pauseTimeLeft -= 1
			messageLbl.text = self.getCountDownTime()
		} else if pauseTimeLeft == 0 {
			self.resumeGame()
		}
	}
	
	func getCountDownTime() -> String {
		return String(format: "Pause time left: %02d:%02d", pauseTimeLeft / 60, pauseTimeLeft - (pauseTimeLeft / 60 * 60))
	}
	
	func resumeGame() {
		if MyAppDelegate.brain.currentPlayer == .Red {
			if MyAppDelegate.playerInfoView.player1PausesLeft > 0 {
				MyAppDelegate.playerInfoView.player1PausesLeft -= 1
			}
		} else {
			if MyAppDelegate.playerInfoView.player2PausesLeft > 0 {
				MyAppDelegate.playerInfoView.player2PausesLeft -= 1
			}
		}
		MyAppDelegate.playerInfoView.player1PauseBtn.isUserInteractionEnabled = (MyAppDelegate.playerInfoView.player1PausesLeft != 0)
		MyAppDelegate.playerInfoView.player2PauseBtn.isUserInteractionEnabled = (MyAppDelegate.playerInfoView.player2PausesLeft != 0)
		MyAppDelegate.playerInfoView.updatePlayerPausesLeft()
		self.stopTimers()
		self.removeFromSuperview()
		MyAppDelegate.navigationView.configTimerState(false)
	}
	
	@IBAction func userClickedBtn1(_ sender: Any) {
		self.removeFromSuperview()
		if alertStyle == .Winner {
			self.delegate.dismissViewController()
		}
		MyAppDelegate.navigationView.configTimerState(false)
	}
	
	@IBAction func userClickedBtn2(_ sender: Any) {
		if alertStyle == .PauseGame {
			self.loadText(.Paused)
			self.startTimers()
		} else {
			self.removeFromSuperview()
			MyAppDelegate.navigationView.configTimerState(false)
			if alertStyle == .Winner {
				self.delegate.replayGame()
			} else if alertStyle == .ExitGame {
				self.delegate.dismissViewController()
			}
		}
	}
	
	@IBAction func userClickedResumeBtn(_ sender: Any) {
		self.resumeGame()
	}
}
