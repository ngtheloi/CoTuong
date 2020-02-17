//
//  Horse.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Horse: Piece {
	override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
		// // For horse, it requires a "日" shape with 3 steps
		let possibleMoves: [Vector] = [
			Vector(x: position.x - 1, y: position.y + 2),
			Vector(x: position.x - 1, y: position.y - 2),
			Vector(x: position.x - 2, y: position.y - 1),
			Vector(x: position.x - 2, y: position.y + 1),
			Vector(x: position.x + 1, y: position.y + 2),
			Vector(x: position.x + 1, y: position.y - 2),
			Vector(x: position.x + 2, y: position.y + 1),
			Vector(x: position.x + 2, y: position.y - 1)
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
		
		if let nextState = boardStates[move.x][move.y] {
			if nextState.owner == self.owner {
				return false
			}
		}
		
		let boo = position.x < move.x ? (min: position.x, max: move.x) :
			(min: move.x, max: self.position.x)
		let foo = position.y < move.y ? (min: position.y, max: move.y) :
			(min: move.y, max: position.y)
		if (foo.max - foo.min == 2) && (boardStates[position.x][foo.min + 1] == nil) {
			return true
		}
		if (boo.max - boo.min == 2) && (boardStates[boo.min + 1][position.y] == nil) {
			return true
		}
		
		return false
	}
}
