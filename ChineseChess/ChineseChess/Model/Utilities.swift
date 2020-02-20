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

enum AssistantStyle {
	case Setting
	case History
}

class MyAppDelegate: NSObject {
	static var brain = ChessCore()
	
	static var navigationView: NavigationView!
	
	static var playerInfoView: PlayerInfoView!
	
	static var alertView: AlertView!
	
	static var setting: GameSetting = {
		let timeLeft: Int = UserDefaults.standard.integer(forKey: "timeLeft")
		let pausesLeft: Int = UserDefaults.standard.integer(forKey: "pausesLeft")
		let pauseTimeLeft: Int = UserDefaults.standard.integer(forKey: "pauseTimeLeft")
		return GameSetting(timeLeft, pausesLeft, pauseTimeLeft)
	}()
	
	static func getTerritoryOwner(_ x: Int) -> Player {
		return (x < Board.riverRow) ? .Black : .Red
    }
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

extension Vector {
	func isForbidden() -> Bool {
        if self.y >= 3 && self.y <= 5 {
            if (self.x >= 0 && self.x <= 2) || (self.x >= 7 && self.x <= 9) {
                return true
            }
        }
        return false
    }
    
    func isOutOfBoard() -> Bool {
        if self.x < 0 || self.x >= 10/*Board.rows*/ {
			return true
		}
        
        if self.y < 0 || self.y >= 9/*Board.columns*/ {
            return true
        }
        
        return false
    }
}
