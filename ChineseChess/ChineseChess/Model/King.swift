//
//  King.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class King: Piece {
    override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
        // King can move 1 step in four directions.
        let possibleMoves: [Vector] = [
			Vector(x: position.x + 1, y: position.y),
			Vector(x: position.x - 1, y: position.y),
			Vector(x: position.x, y: position.y + 1),
			Vector(x: position.x, y: position.y - 1)
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
        // King can only move inside forbidden area
        if !move.isForbidden() {
            return false
        }
        
        if let nextState = boardStates[move.x][move.y] {
            if nextState.owner == self.owner {
                return false
            }
        }
        
        return true
    }
}
