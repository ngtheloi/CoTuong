//
//  ContentView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class ContentView: UIView {
    // BoardView
    public lazy var board: BoardView = self.createBoard()
    
    private func createBoard() -> BoardView {
        let board = BoardView()
        board.isOpaque = false
        return board
    }
    
    private func positionBoard(_ board: BoardView) {
        board.frame = bounds
        board.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // PieceView
    private lazy var pieces: [PieceView] = self.createPieces()
    
    private func createPieces() -> [PieceView] {
        var ret: [PieceView] = []
        let initialGameStates = Board.initialBoardStates
        
        for i in 0 ..< Board.rows {
            for j in 0 ..< Board.columns {
                if let piece = initialGameStates[i][j] {
                    ret.append(PieceView(piece))
                }
            }
        }
        return ret
    }
    
    private func positionPiece(_ piece: PieceView, _ center: CGPoint) {
        let size = board.gridWidth
        piece.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        piece.center = center
    }
    
    public var pieceViews: [PieceView] {
        return pieces
    }
    
    // Possible Move Hints
    public func createHint(_ center: CGPoint) -> UIImageView {
        let size = board.gridWidth * 0.9
        let hintView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        hintView.image = UIImage(named: "cursor")
        hintView.center = center
        addSubview(hintView)
        return hintView
    }
    
    public func removeHint(_ hintView: UIImageView) {
        hintView.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
		self.positionBoard(self.board)
        
        let m = board.boardCoordinates
        for p in pieces {
            let i = p.piece.position.x
            let j = p.piece.position.y
			self.positionPiece(p, m[i][j])
        }
    }
}
