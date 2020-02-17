//
//  PieceView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1502//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class PieceView: UIButton {
	var piece: Piece
	
	init(_ piece: Piece) {
		self.piece = piece
		super.init(frame: CGRect.zero)
		
		self.setup(piece)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup(_ piece: Piece) {
		var backgroundImgName: String
		
		switch piece.owner {
		case .Black:
			backgroundImgName = "black"
		case .Red:
			backgroundImgName = "red"
		}
		
		switch piece {
		case is Bishop:
			backgroundImgName += "-bishop"
		case is Horse:
			backgroundImgName += "-horse"
		case is Guard:
			backgroundImgName += "-guard"
		case is Rook:
			backgroundImgName += "-rook"
		case is Cannon:
			backgroundImgName += "-cannon"
		case is Pawn:
			backgroundImgName += "-pawn"
		case is King:
			backgroundImgName += "-king"
		default:
			break
		}
		
		self.setBackgroundImage(UIImage(named: backgroundImgName), for: .normal)
		self.setImage(UIImage(named: "cursor"), for: .selected)
		
		self.layer.masksToBounds = true
		self.layer.display()
	}
	
	func setSelection() {
		self.isSelected = true
	}
	
	func removeSelection() {
		self.isSelected = false
	}
}
