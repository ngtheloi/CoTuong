//
//  PlayerInfoView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

protocol PlayerInfoViewDelegate {
	func pauseGame()
}

class PlayerInfoView: UIView {
	// MARK: - Outlet
	// Player 1
	@IBOutlet weak var player1InfoView: UIView!
	@IBOutlet weak var player1NameLbl: UILabel!
	@IBOutlet weak var player1PausesLeftLbl: UILabel!
	@IBOutlet weak var player1PauseBtn: UIButton!
	
	// Player 2
	@IBOutlet weak var player2InfoView: UIView!
	@IBOutlet weak var player2NameLbl: UILabel!
	@IBOutlet weak var player2PausesLeftLbl: UILabel!
	@IBOutlet weak var player2PauseBtn: UIButton!
	
	static let identifier = "PlayerInfoView"
	var delegate: PlayerInfoViewDelegate!
	var player1PausesLeft: Int = MyAppDelegate.setting.pausesLeft
	var player2PausesLeft: Int = MyAppDelegate.setting.pausesLeft
	
	override func awakeFromNib() {
		super.awakeFromNib()
		player1InfoView.layer.borderWidth = 1
		player2InfoView.layer.borderWidth = 1
		self.updatePlayerPausesLeft()
	}
	
	func updatePlayerPausesLeft() {
		self.player1PausesLeftLbl.text = String(format: "Pauses left: %d", player1PausesLeft)
		self.player2PausesLeftLbl.text = String(format: "Pauses left: %d", player2PausesLeft)
	}
	
	func updatePlayerInfoViewState(_ currentPlayer: Player) {
		let activeColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
		let inActiveColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:1.0)
		
		if currentPlayer == .Red {// Player 1 active, Player 2 inactive
			player1InfoView.layer.borderColor = activeColor.cgColor
			player1PausesLeftLbl.textColor = activeColor
			player1PauseBtn.setTitleColor(activeColor, for: .normal)
			player1PauseBtn.tintColor = activeColor
			
			player2InfoView.layer.borderColor = inActiveColor.cgColor
			player2PausesLeftLbl.textColor = inActiveColor
			player2PauseBtn.setTitleColor(inActiveColor, for: .normal)
			player2PauseBtn.tintColor = inActiveColor
		} else if currentPlayer == .Black {// Player 1 inactive, Player 2 active
			player1InfoView.layer.borderColor = inActiveColor.cgColor
			player1PausesLeftLbl.textColor = inActiveColor
			player1PauseBtn.setTitleColor(inActiveColor, for: .normal)
			player1PauseBtn.tintColor = inActiveColor
			
			player2InfoView.layer.borderColor = activeColor.cgColor
			player2PausesLeftLbl.textColor = activeColor
			player2PauseBtn.setTitleColor(activeColor, for: .normal)
			player2PauseBtn.tintColor = activeColor
		}
		self.updatePauseButtonState(currentPlayer)
	}
	
	func updatePauseButtonState(_ currentPlayer: Player) {
		let player1Check = currentPlayer == .Red && player1PausesLeft > 0
		player1PauseBtn.isUserInteractionEnabled = player1Check
		
		let player2Check = currentPlayer == .Black && player2PausesLeft > 0
		player2PauseBtn.isUserInteractionEnabled = player2Check
	}
	
	// MARK: - Action
	@IBAction func userClickedPauseBtn(_ sender: UIButton) {
		self.delegate.pauseGame()
	}
}
