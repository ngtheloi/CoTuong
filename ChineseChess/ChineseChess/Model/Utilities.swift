//
//  Utilities.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

struct Vector: Equatable {
    var x: Int
    var y: Int
}

enum Player {
    case Black
    case Red
}

enum PieceStatus {
    case Alive
    case Dead
}

enum AlertStyle {
	case Winner
	case ExitGame
	case PauseGame
	case Paused
}

class MyAppDelegate: NSObject {
	static var brain = ChessCore()
	
	static var navigationView: NavigationView!
	
	static var playerInfoView: PlayerInfoView!
	
	static var alertView: AlertView!
	
	static var setting: GameSetting = {
		let timeLeft: Int = UserDefaults.standard.object(forKey: "timeLeft") as? Int ?? 60
		let pausesLeft: Int = UserDefaults.standard.object(forKey: "pausesLeft") as? Int ?? 2
		let pauseTimeLeft: Int = UserDefaults.standard.object(forKey: "pauseTimeLeft") as? Int ?? 60
		return GameSetting(timeLeft, pausesLeft, pauseTimeLeft)
	}()
}

struct GameSetting {
	var timeLeft: Int //seconds
	var pausesLeft: Int
	var pauseTimeLeft: Int //seconds
	
	init(_ timeLeft: Int, _ pausesLeft: Int, _ pauseTimeLeft: Int) {
		self.timeLeft = timeLeft
		self.pausesLeft = pausesLeft
		self.pauseTimeLeft = pauseTimeLeft
	}
}
