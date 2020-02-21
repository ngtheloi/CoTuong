//
//  NavigationView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

protocol NavigationViewDelegate {
	func backToMainMenu()
	func timeOut()
}

class NavigationView: UIView {
	static let identifier = "NavigationView"
	var delegate: NavigationViewDelegate!
	var timer: Timer!
	var timeLeft = MyAppDelegate.setting.timeLeft
	
	@IBOutlet weak var timeLeftLbl: UILabel!
	
	func startTimers(_ restart: Bool) {
		if restart {
			self.stopTimers()
			timeLeft = MyAppDelegate.setting.timeLeft
		}
		timeLeftLbl.text = self.getCountDownTime()
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
		if timeLeft > 0 {
			timeLeft -= 1
			timeLeftLbl.text = self.getCountDownTime()
		} else if timeLeft == 0 {
			MyAppDelegate.brain.winner = (MyAppDelegate.brain.currentPlayer == .Red) ? .Black : .Red
			self.stopTimers()
			self.delegate.timeOut()
		}
	}
	
	func getCountDownTime() -> String {
		return String(format: "Time left: %02d:%02d", timeLeft / 60, timeLeft - (timeLeft / 60 * 60))
	}
	
	func configTimerState(_ pause: Bool) {
		if self.timer != nil {
			if pause {
				self.timer.invalidate()
			} else {
				self.startTimers(false)
			}
		}
	}
	
	@IBAction func userClickedBackBtn(_ sender: Any) {
		self.delegate.backToMainMenu()
	}
}
