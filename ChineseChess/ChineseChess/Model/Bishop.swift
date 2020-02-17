//
//  Bishop.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Bishop: Piece {
	override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
        let possibleMoves: [Vector] = [
			Vector(x: position.x - 2, y: position.y - 2),
			Vector(x: position.x - 2, y: position.y + 2),
			Vector(x: position.x + 2, y: position.y - 2),
			Vector(x: position.x + 2, y: position.y + 2)
        ]
        
        var ret: [Vector] = []
        for move in possibleMoves {
			if self.isValidMove(move, boardStates) {
                ret.append(move)
            }
        }
        return ret
    }
    
    override func isValidMove(_ move: Vector, _ boardStates: [[Piece?]]) -> Bool {
        if Board.isOutOfBoard(move) {
            return false
        }
        
        // Bishop can not accross the river on the board
        if Board.getTerritoryOwner(move.x) != self.owner {
            return false
        }
        
        if let nextState = boardStates[move.x][move.y] {
            if nextState.owner == self.owner {
                return false
            }
        }
        
        let minrow = min(self.position.x, move.x)
        let mincol = min(self.position.y, move.y)
        if boardStates[minrow + 1][mincol + 1] == nil {
            return true
        }

        return false
    }
}
