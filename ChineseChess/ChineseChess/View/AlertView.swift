//
//  AlertView.swift
//  ChineseChess
//
//  Created by Loi Nguyen on 1802//2020.
//  Copyright © 2020 Loi Nguyen. All rights reserved.
//

import UIKit

class AlertView: UIView {
	@IBOutlet weak var alertContentView: UIView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var messageLbl: UILabel!
	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var okBtn: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func loadText(_ title: String, _ message: String) {
		titleLbl.text = title
		messageLbl.text = message
		self.loadUI()
	}
	
	func loadUI() {
		let viewCorner = alertContentView.bounds.size.height / 10
		alertContentView.layer.cornerRadius = viewCorner
		
		alertContentView.layer.borderWidth = 1
		alertContentView.layer.borderColor = UIColor.white.cgColor
		
		let buttonCorner = cancelBtn.bounds.size.height / 2
		cancelBtn.layer.cornerRadius = buttonCorner
		okBtn.layer.cornerRadius = buttonCorner
		
		cancelBtn.layer.borderWidth = 1
		okBtn.layer.borderWidth = 1
		
		cancelBtn.layer.borderColor = UIColor.white.cgColor
		okBtn.layer.borderColor = UIColor.white.cgColor
	}
}
