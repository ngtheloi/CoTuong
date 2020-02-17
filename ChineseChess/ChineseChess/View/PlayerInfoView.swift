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
	var player1PausesLeft: Int = 2
	var player2PausesLeft: Int = 2
	
	override func awakeFromNib() {
		super.awakeFromNib()
		player1InfoView.layer.borderWidth = 1
		player2InfoView.layer.borderWidth = 1
		self.updateInfo()
	}
	
	func updateInfo() {
		self.player1PausesLeftLbl.text = String(format: "Pauses left: %d", player1PausesLeft)
		self.player2PausesLeftLbl.text = String(format: "Pauses left: %d", player2PausesLeft)
	}
	
	func changePlayerInfoStateView(_ currentPlayer: Player) {
		let activeColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
		let inActiveColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.0)
		if currentPlayer == .Red {
			player1InfoView.layer.borderColor = activeColor.cgColor
//			player1NameLbl.textColor = activeColor
			player1PausesLeftLbl.textColor = activeColor
			player1PauseBtn.setTitleColor(activeColor, for: .normal)
			player1PauseBtn.tintColor = activeColor
			player1PauseBtn.isUserInteractionEnabled = true
			
			player2InfoView.layer.borderColor = inActiveColor.cgColor
//			player2NameLbl.textColor = inActiveColor
			player2PausesLeftLbl.textColor = inActiveColor
			player2PauseBtn.setTitleColor(inActiveColor, for: .normal)
			player2PauseBtn.tintColor = inActiveColor
			player2PauseBtn.isUserInteractionEnabled = false
		} else if currentPlayer == .Black {
			player1InfoView.layer.borderColor = inActiveColor.cgColor
//			player1NameLbl.textColor = inActiveColor
			player1PausesLeftLbl.textColor = inActiveColor
			player1PauseBtn.setTitleColor(inActiveColor, for: .normal)
			player1PauseBtn.tintColor = inActiveColor
			player1PauseBtn.isUserInteractionEnabled = false
			
			player2InfoView.layer.borderColor = activeColor.cgColor
//			player2NameLbl.textColor = activeColor
			player2PausesLeftLbl.textColor = activeColor
			player2PauseBtn.setTitleColor(activeColor, for: .normal)
			player2PauseBtn.tintColor = activeColor
			player2PauseBtn.isUserInteractionEnabled = true
		}
	}
	
	// MARK: - Action
	@IBAction func userClickedPauseBtn(_ sender: UIButton) {
		if sender == player1PauseBtn {
			if player1PausesLeft > 0 {
				player1PausesLeft -= 1
			} else {
				player1PauseBtn.isUserInteractionEnabled = false
			}
		} else {
			if player2PausesLeft > 0 {
				player2PausesLeft -= 1
			} else {
				player2PauseBtn.isUserInteractionEnabled = false
			}
		}
		self.updateInfo()
	}
}
