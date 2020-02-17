//
//  BoardView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class BoardView: UIView {
	var lineWidth: CGFloat = 1 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var color: UIColor = .black {
		didSet {
			setNeedsDisplay()
		}
	}
	
	// Chess board has 9 rows grid and 8 columns grid
	let boardRowsNumber: CGFloat = 9
	
	let boardColsNumber: CGFloat = 8
	
	private lazy var boardHeight: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
	
	public lazy var gridWidth: CGFloat = self.boardHeight / self.boardRowsNumber
	
	private var boardWidth: CGFloat {
		return gridWidth * boardColsNumber
	}
	
	private var boardCenter: CGPoint {
		return CGPoint(x: bounds.midX, y: bounds.midY - 50)
	}
	
	public lazy var boardCoordinates: [[CGPoint]] = self.calculateBoardCoordinates()
	
	private func calculateBoardCoordinates() -> [[CGPoint]] {
		let startX = boardCenter.x - (boardWidth / 2)
		let startY = boardCenter.y - (boardHeight / 2)
		let endX = startX + boardWidth
		let endY = startY + boardHeight
		
		var ret = [[CGPoint]]()
		for y in stride(from: startY, through: endY, by: gridWidth) {
			var foo = [CGPoint]()
			for x in stride(from: startX, through: endX, by: gridWidth) {
				foo.append(CGPoint(x: x, y: y))
			}
			ret.append(foo)
		}
		return ret
	}
	
	private func pathForLine(_ startPoint: CGPoint, _ endPoint: CGPoint) -> UIBezierPath {
		let path = UIBezierPath()
		path.move(to: startPoint)
		path.addLine(to: endPoint)
		path.close()
		path.lineWidth = lineWidth
		return path
	}
	
	override func draw(_ rect: CGRect) {
		color.set()
		
		let m = self.boardCoordinates
		for i in 0...9 {
			// Draw the horizontal line
			self.pathForLine(m[i][0], m[i][8]).stroke()
			// Draw the vertical line
			if (i == 0 || i == 8) {
				self.pathForLine(m[0][i], m[9][i]).stroke()
			} else if (i != 9) {
				self.pathForLine(m[0][i], m[4][i]).stroke()
				self.pathForLine(m[5][i], m[9][i]).stroke()
			}
		}
		
		// Draw diagonal
		pathForLine(m[0][3], m[2][5]).stroke()
		pathForLine(m[0][5], m[2][3]).stroke()
		pathForLine(m[7][3], m[9][5]).stroke()
		pathForLine(m[7][5], m[9][3]).stroke()
		
		self.initSubView()
	}
	
	func initSubView() {
		MyAppDelegate.navigationView = Bundle.main.loadNibNamed(NavigationView.identifier, owner: self, options: nil)?.first as? NavigationView
		MyAppDelegate.navigationView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 44)
		self.addSubview(MyAppDelegate.navigationView)
		
		MyAppDelegate.playerInfoView = Bundle.main.loadNibNamed(PlayerInfoView.identifier, owner: self, options: nil)?.first as? PlayerInfoView
		let y = bounds.size.height - MyAppDelegate.playerInfoView.bounds.size.height
		MyAppDelegate.playerInfoView.frame = CGRect(x: 0, y: y, width: bounds.size.width, height: MyAppDelegate.playerInfoView.bounds.size.height)
		MyAppDelegate.playerInfoView.updatePlayerInfoViewState(MyAppDelegate.brain.currentPlayer)
		self.addSubview(MyAppDelegate.playerInfoView)
	}
}
