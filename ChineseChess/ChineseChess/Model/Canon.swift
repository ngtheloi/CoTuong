//
//  Canon.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class Cannon: Piece {
	private var obstacleNumber: Int = 0
	
	override func nextPossibleMoves(_ boardStates: [[Piece?]]) -> [Vector] {
		var ret: [Vector] = []
		
		// The same row
		obstacleNumber = 0
		for x in stride(from: position.x - 1, through: 0, by: -1) {
			if self.isValidMove(Vector(x: x, y: position.y), boardStates) {
				ret.append(Vector(x: x, y: position.y))
			}
		}
		
		obstacleNumber = 0
		for x in stride(from: position.x + 1, through: Board.rows - 1, by: +1) {
			if self.isValidMove(Vector(x: x, y: position.y), boardStates) {
				ret.append(Vector(x: x, y: position.y))
			}
			
		}
		
		// The same column
		obstacleNumber = 0
		for y in stride(from: position.y - 1, through: 0, by: -1) {
			if self.isValidMove(Vector(x: position.x, y: y), boardStates) {
				ret.append(Vector(x: position.x, y: y))
			}
			
		}
		
		obstacleNumber = 0
		for y in stride(from: position.y + 1, through: Board.columns - 1, by: +1) {
			if self.isValidMove(Vector(x: position.x, y: y), boardStates) {
				ret.append(Vector(x: position.x, y: y))
			}
		}
		
		return ret
	}
	
	
	override func isValidMove(_ move: Vector, _ boardStates: [[Piece?]]) -> Bool {
		if move.isOutOfBoard() {
			return false
		}
		
		if obstacleNumber > 1 {
			return false
		}
		
		if obstacleNumber == 1 {
			if let nextstate = boardStates[move.x][move.y] {
				obstacleNumber += 1
				if nextstate.owner != self.owner {
					return true
				}
			}
			return false
		}
		
		if obstacleNumber == 0 {
			if boardStates[move.x][move.y] != nil {
				obstacleNumber += 1
				return false
			} else {
				return true
			}
		}
		
		return false
	}
}
