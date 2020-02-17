//
//  ChessCode.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import Foundation

class ChessCore: NSObject {
	public var pending: Piece?
	public var currentPlayer: Player = .Red // Red player is the first one to play
	public var gameStates = Board.initialBoardStates
	public var winner: Player?
	
	public func setPiece(_ piece: Piece) {
		if winner != nil {
			return
		}
		
		if let firstSelection = pending {
			/* If the second piece selection belongs to
			* the same player with the first piece, set pending piece to the
			* second one.
			*/
			if firstSelection.owner == piece.owner {
				pending = piece
				return
			}
			
			if self.checkMovementAvailability(piece.position) {
				self.eatPiece(piece)
			}
		} else {
			if piece.owner == currentPlayer {
				pending = piece
			}
		}
	}
	
	public func checkMovementAvailability(_ destination: Vector) -> Bool {
		if let piece = pending {
			let nextPossibleMoves = piece.nextPossibleMoves(gameStates)
			
			if nextPossibleMoves.contains(where: {$0 == destination}) {
				// Update gamestates
				gameStates[piece.position.x][piece.position.y] = nil
				gameStates[destination.x][destination.y] = piece
				piece.setPosition(destination)
				
				// Next player's turn
				currentPlayer = turnPlayer(currentPlayer)
				
				pending = nil
				return true
			}
		}
		return false
	}
	
	private func eatPiece(_ food: Piece) {
		// Set the piece status to Died
		food.status = .Dead
		
		if food is King {
			winner = (food.owner == .Black) ? .Red : .Black
		}
	}
	
	private func turnPlayer(_ player: Player) -> Player {
		return player == .Red ? .Black: .Red
	}
	
	// Reset everything
	func replay() {
		pending = nil
		currentPlayer = .Red
		gameStates = Board.initialBoardStates
		winner = nil
		
		for i in 0 ..< Board.rows {
			for j in 0 ..< Board.columns {
				if let piece = gameStates[i][j] {
					piece.setPosition(Vector(x: i, y: j))
					
					// reset all the piece to Alive status
					piece.status = .Alive
				}
			}
		}
	}
}
