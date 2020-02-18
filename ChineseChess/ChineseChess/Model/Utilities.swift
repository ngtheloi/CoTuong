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
}

class MyAppDelegate: NSObject {
	static var brain = ChessCore()
	
	static var navigationView: NavigationView!
	
	static var playerInfoView: PlayerInfoView!
	
	static var alertView: AlertView!
}
