//
//  Rook.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Rook: Piece {
	private var obstacleNumber: Int = 0
	
	override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
		var ret: [Vector] = []
		
		// The same row
		obstacleNumber = 0
		for _x in stride(from: position.x - 1, through: 0, by: -1) {
			if obstacleNumber == 1 {
				break
			}
			
			if self.isValidMove(Vector(x: _x, y: position.y), boardStates) {
				ret.append(Vector(x: _x, y: position.y))
			}
		}
		
		obstacleNumber = 0
		for x in stride(from: position.x + 1, to: Board.rows, by: +1) {
			if obstacleNumber == 1 {
				break
			} else if self.isValidMove(Vector(x: x, y: position.y), boardStates) {
				ret.append(Vector(x: x, y: position.y))
			}
		}
		
		// The same column
		obstacleNumber = 0
		for y in stride(from: position.y - 1, through: 0, by: -1) {
			if obstacleNumber == 1 {
				break
			} else if self.isValidMove(Vector(x: position.x, y: y), boardStates) {
				ret.append(Vector(x: position.x, y: y))
			}
		}
		
		obstacleNumber = 0
		for y in stride(from: position.y + 1, to: Board.columns, by: +1) {
			if obstacleNumber == 1 {
				break
			} else if self.isValidMove(Vector(x: position.x, y: y), boardStates) {
				ret.append(Vector(x: position.x, y: y))
			}
		}
		
		return ret
	}
	
	
	override func isValidMove(_ move: Vector, _ boardStates: [[Piece?]]) -> Bool {
		if move.isOutOfBoard() {
			return false
		}
		
		if obstacleNumber >= 1 {
			return false
		}
		
		if let nextstate = boardStates[move.x][move.y] {
			obstacleNumber += 1
			return (nextstate.owner == self.owner) ? false : true
		}
		
		return true
	}
}
