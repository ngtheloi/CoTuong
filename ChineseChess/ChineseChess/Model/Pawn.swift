//
//  Pawn.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Pawn: Piece {
	override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
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
		if move.isOutOfBoard() {
			return false
		}
		
		if let nextState = boardStates[move.x][move.y] {
			if nextState.owner == self.owner {
				return false
			}
		}
		
		if Board.getTerritoryOwner(move.x) == self.owner {
			if (self.owner == .Red && position.x - 1 == move.x) {
				return true
			}
			
			if (self.owner == .Black && position.x + 1 == move.x) {
				return true
			}
		} else {
			if (self.owner == .Red && move.x <= position.x) {
				return true
			}
			
			if (self.owner == .Black && move.x >= position.x) {
				return true
			}
		}
		
		return false
	}
}
