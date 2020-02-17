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

class MyAppDelegate: NSObject {
	static var brain = ChessCore()
}
