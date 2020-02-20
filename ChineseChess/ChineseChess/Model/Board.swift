//
//  Board.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Board: NSObject {
    // Chinese Chess has 10 rows and 9 columns
    public static let rows: Int = 10
    public static let columns: Int = 9
    public static let riverRow: Int = 5
    
    public static var initialBoardStates: [[Piece?]] = Board.initPiecesStates()
    
    public static func getTerritoryOwner(_ x: Int) -> Player {
		return (x < riverRow) ? .Black : .Red
    }
    
    private static func initPiecesStates() -> [[Piece?]] {
        // Initialize a board and populate with nil
        
        var board = [[Piece?]](repeating: [Piece?] (repeating: nil, count: Board.columns), count: Board.rows)
		/*
		Each player starts the game with these pieces:
		1 king, 2 guards, 2 elephants, 2 knights, 2 rooks, 2 cannons and 5 pawns.
		*/
        // Black Player
        board[0][0] = Rook(.Black, Vector(x: 0, y: 0))
        board[0][1] = Horse(.Black, Vector(x: 0, y: 1))
        board[0][2] = Bishop(.Black, Vector(x: 0, y: 2))
        board[0][3] = Guard(.Black, Vector(x: 0, y: 3))
        board[0][4] = King(.Black, Vector(x: 0, y: 4))
        board[0][5] = Guard(.Black, Vector(x: 0, y: 5))
        board[0][6] = Bishop(.Black, Vector(x: 0, y: 6))
        board[0][7] = Horse(.Black, Vector(x: 0, y: 7))
        board[0][8] = Rook(.Black, Vector(x: 0, y: 8))
        board[2][1] = Cannon(.Black, Vector(x: 2, y: 1))
        board[2][7] = Cannon(.Black, Vector(x: 2, y: 7))
        board[3][0] = Pawn(.Black, Vector(x: 3, y: 0))
        board[3][2] = Pawn(.Black, Vector(x: 3, y: 2))
        board[3][4] = Pawn(.Black, Vector(x: 3, y: 4))
        board[3][6] = Pawn(.Black, Vector(x: 3, y: 6))
        board[3][8] = Pawn(.Black, Vector(x: 3, y: 8))
        
        // Red Player
        board[6][0] = Pawn(.Red, Vector(x: 6, y: 0))
        board[6][2] = Pawn(.Red, Vector(x: 6, y: 2))
        board[6][4] = Pawn(.Red, Vector(x: 6, y: 4))
        board[6][6] = Pawn(.Red, Vector(x: 6, y: 6))
        board[6][8] = Pawn(.Red, Vector(x: 6, y: 8))
        board[7][1] = Cannon(.Red, Vector(x: 7, y: 1))
        board[7][7] = Cannon(.Red, Vector(x: 7, y: 7))
        board[9][0] = Rook(.Red, Vector(x: 9, y: 0))
        board[9][1] = Horse(.Red, Vector(x: 9, y: 1))
        board[9][2] = Bishop(.Red, Vector(x: 9, y: 2))
        board[9][3] = Guard(.Red, Vector(x: 9, y: 3))
        board[9][4] = King(.Red, Vector(x: 9, y: 4))
        board[9][5] = Guard(.Red, Vector(x: 9, y: 5))
        board[9][6] = Bishop(.Red, Vector(x: 9, y: 6))
        board[9][7] = Horse(.Red, Vector(x: 9, y: 7))
        board[9][8] = Rook(.Red, Vector(x: 9, y: 8))

        return board
    }
}
