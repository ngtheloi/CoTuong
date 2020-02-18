//
//  GameViewController.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	static let identifier = "GameViewController"
	
	private var boardView: BoardView {
		return chessView.board
	}
	
	private var boardCoordinates: [[CGPoint]] {
		return boardView.boardCoordinates
	}
	
	private var gridWidth: CGFloat {
		return boardView.gridWidth
	}
	
	private var boardOrigin: CGPoint {
		return boardCoordinates[0][0]
	}
	
	private var boardTermination: CGPoint {
		return boardCoordinates[9][8]
	}
	
	private var pieceModelViewReference: Dictionary<Int, PieceView> = [:]
	
	private var nextPossibleMovesView: [UIImageView] = []
	
	private var pendingView: PieceView?
	
	// MARK: - Outlet
	@IBOutlet weak var chessView: ContentView!
	
	// Bind piece model with piece view together
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(getCoordinates))
		tap.numberOfTapsRequired = 1
		boardView.addGestureRecognizer(tap)
		chessView.addSubview(boardView)
		
		for pieceView in chessView.pieceViews {
			pieceView.addTarget(self,action: #selector(performOperation(_:)), for: .touchUpInside)
			chessView.addSubview(pieceView)
			
			pieceModelViewReference[pieceView.piece.pid] = pieceView
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		MyAppDelegate.navigationView.delegate = self
	}
	
	@objc func performOperation(_ sender: PieceView!) {
		MyAppDelegate.brain.setPiece(sender.piece)
		
		if let piece = MyAppDelegate.brain.pending {
			// Clear last piece view if exists
			self.clearPendingPieceView()
			
			// Set the latest piece view
			pendingView = pieceModelViewReference[piece.pid]
			pendingView?.setSelection()
			self.showPossibleMovesView(piece.nextPossibleMoves(MyAppDelegate.brain.gameStates))
		} else {
			if pendingView != nil {
				let x = pendingView!.piece.position.x, y = pendingView!.piece.position.y
				pendingView?.center = boardCoordinates[x][y]
				
				if sender.piece.status == .Dead { // It means sender has been eaten
					sender.isHidden = true
				}
			}
			self.clearPendingPieceView()
		}
		checkWinner()
	}
	
	@objc func getCoordinates(recognizer: UITapGestureRecognizer) {
		let position = recognizer.location(in: boardView)
		let x = round(position.x)
		let y = round(position.y)
		
		if (y < boardOrigin.y - gridWidth / 2) || (y > boardTermination.y + gridWidth / 2) {
			return
		}
		
		let col = Int(round((x - boardOrigin.x) / gridWidth))
		let row = Int(round((y - boardOrigin.y) / gridWidth))
		
		if MyAppDelegate.brain.checkMovementAvailability(Vector(x: row, y: col)) {
			pendingView?.center = boardCoordinates[row][col]
			self.clearPendingPieceView()
			MyAppDelegate.playerInfoView.updatePlayerInfoViewState(MyAppDelegate.brain.currentPlayer)
		}
	}
	
	private func showPossibleMovesView(_ possibleMoves: [Vector]) {
		for move in possibleMoves {
			nextPossibleMovesView.append(
				chessView.createHint(boardCoordinates[move.x][move.y])
			)
		}
	}
	
	private func clearPossibleMovesView() {
		for hint in nextPossibleMovesView {
			chessView.removeHint(hint)
		}
		nextPossibleMovesView = []
	}
	
	private func clearPendingPieceView() {
		if pendingView != nil {
			pendingView?.removeSelection()
			pendingView = nil
		}
		self.clearPossibleMovesView()
	}
	
	private func checkWinner() {
		if MyAppDelegate.brain.winner != nil {
			MyAppDelegate.alertView = Bundle.main.loadNibNamed(AlertView.identifier, owner: self, options: nil)?.first as? AlertView
			MyAppDelegate.alertView.delegate = self
			MyAppDelegate.alertView.loadText(.Winner)
			self.view.addSubview(MyAppDelegate.alertView)
		}
	}
}

extension GameViewController: NavigationViewDelegate {
	func dismissViewController() {
		self.dismiss(animated: true, completion: nil)
	}
	
	func timeOut() {
		self.checkWinner()
	}
}

extension GameViewController: AlertViewDelegate {
	func replayGame() {
		MyAppDelegate.brain.replay()
		self.clearPendingPieceView()
        
		for (_, pv) in self.pieceModelViewReference {
			pv.center = self.boardCoordinates[pv.piece.position.x][pv.piece.position.y]
            pv.isHidden = false
        }
	}
}
