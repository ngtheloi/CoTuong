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
	@IBOutlet weak var alertContentView: UIView!
	// Outlet
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var messageLbl: UILabel!
	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var okBtn: UIButton!
	
	static let identifier = "AlertView"
	var alertStyle: AlertStyle!
	var delegate: AlertViewDelegate!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func loadText(_ style: AlertStyle) {
		var title = "Errors"
		var message = "Somethings wrong. Please wait!"
		var btn1 = "NO"
		var btn2 = "YES"
		alertStyle = style
		if alertStyle == .Winner {
			title = "Congratulation!"
			message = String(format: "%@ is winner", (MyAppDelegate.brain.winner == .Red) ? "Player 1 is winner" : "Player 2 is winner")
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
		}
		titleLbl.text = title
		messageLbl.text = message
		cancelBtn.setTitle(btn1, for: .normal)
		okBtn.setTitle(btn2, for: .normal)
		self.loadUI()
	}
	
	func loadUI() {
		let viewCorner = alertContentView.bounds.size.height / 10
		alertContentView.layer.cornerRadius = viewCorner
		
		alertContentView.layer.borderWidth = 1
		alertContentView.layer.borderColor = UIColor.white.cgColor
		
		let buttonCorner = cancelBtn.bounds.size.height / 2
		cancelBtn.layer.cornerRadius = buttonCorner
		okBtn.layer.cornerRadius = buttonCorner
		
		cancelBtn.layer.borderWidth = 1
		okBtn.layer.borderWidth = 1
		
		cancelBtn.layer.borderColor = UIColor.white.cgColor
		okBtn.layer.borderColor = UIColor.white.cgColor
	}
	
	@IBAction func userClickedBtn1(_ sender: Any) {
		self.removeFromSuperview()
		if alertStyle == .Winner {
			self.delegate.dismissViewController()
		}
	}
	
	@IBAction func userClickedBtn2(_ sender: Any) {
		self.removeFromSuperview()
		if alertStyle == .Winner {
			self.delegate.replayGame()
		} else if alertStyle == .ExitGame {
			self.delegate.dismissViewController()
		} else if alertStyle == .PauseGame {
			// Pause game
		}
	}
}
